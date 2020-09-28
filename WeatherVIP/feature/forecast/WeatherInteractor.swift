//
//  WeatherInteractor.swift
//  WeatherVIP
//
//  Created by Olorunshola Godwin on 25/09/2020.
//  Copyright © 2020 Olorunshola Godwin. All rights reserved.
//

import Foundation

protocol  WeatherForecastLogic {
    func saveFavoriteCity()
    func fetchWeatherForecast()
    var userInterfaceStyle: UserInterfaceStyle! {get set}
}

class WeatherInteractor: WeatherForecastLogic {
    let locationService: LocationService
    let weatherService: WeatherGateway
    var presenter: WeatherPresentationLogic
    var userInterfaceStyle: UserInterfaceStyle! {
        didSet {
            presenter.userInterfaceStyle = userInterfaceStyle
        }
    }
    var currentDisplayedForecast: Forecast?

    init(presenter: WeatherPresentationLogic, locationService: LocationService = LocationService(),
         weatherService: WeatherGateway ) {
        self.locationService = locationService
        self.weatherService = weatherService
        self.presenter = presenter
    }

    func fetchWeatherForecast() {
        fetchCachedWeatherData()
        requestCurrentLocation()
    }

    func saveFavoriteCity() {
        if let currentDisplayedForecast = currentDisplayedForecast {
            let favoriteCity = FavoriteCity(cityName: currentDisplayedForecast.name ?? "",
                                            temperature: currentDisplayedForecast.main.temp,
                                            lastUpdateDate: currentDisplayedForecast.unixDate,
                                            weatherDescription: currentDisplayedForecast.weather[0].main,
                                            location: currentDisplayedForecast.location)
            weatherService.saveFavoriteCity(favoriteCity)
        }
    }

    func fetchCachedWeatherData() {
        NotificationCenter.default.addObserver(self, selector: #selector(didRetrieveCachedComingDaysWeatherForecast),
                                               name: LocalWeatherGatewayImpl.cacheComingDaysWeather, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didRetrieveCurrentDaysWeatherForecast),
                                                      name: LocalWeatherGatewayImpl.cacheCurrentDayWeather, object: nil)
        weatherService.fetchCachedWeatherData()
    }

    @objc func didRetrieveCachedComingDaysWeatherForecast(_ notification: Notification) {
        if let forecastList = notification.object as? ForecastList {
            presenter.presentFiveDaysWeather(forecastList: forecastList)
        }
    }

    @objc func didRetrieveCurrentDaysWeatherForecast(_ notification: Notification) {
        if let forecast = notification.object as? Forecast {
            currentDisplayedForecast = forecast
            presenter.presentCurrentDayWeather(forecast: forecast)
        }
    }

    func requestCurrentLocation() {
        locationService.delegate = self
        locationService.startLocationRequest()
    }

    func fetchCurrentDayWeather(requestBody: ForecastRequestLocation) {
        weatherService.getCurrentDayWeather(requestBody: requestBody) {[weak self] result in
            switch result {
            case .success(let forecast):
                self?.currentDisplayedForecast = forecast
                self?.presenter.presentCurrentDayWeather(forecast: forecast)
            case .failure(let error):
                self?.presenter.presentError(error: error.localizedDescription)
            }
        }
    }

    func fetchFivedaysWeather(requestBody: ForecastRequestLocation) {
        weatherService.getFivedaysWeather(requestBody: requestBody) { [weak self] result  in
            switch result {
            case .success(let forecastList):
                self?.presenter.presentFiveDaysWeather(forecastList: forecastList)
            case .failure(let error):
                self?.presenter.presentError(error: error.localizedDescription)
            }
        }
    }
}

extension WeatherInteractor: LocationServiceDelegate {
    func didGetLocation(_ lat: String, lng: String) {
        let requestBody = ForecastRequestLocation(latitude: lat, longitude: lng)
        fetchCurrentDayWeather(requestBody: requestBody)
        fetchFivedaysWeather(requestBody: requestBody)
    }

    func locationdidFail(_ reason: String) {
        presenter.presentError(error: reason)
    }
}
