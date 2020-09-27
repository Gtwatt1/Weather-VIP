//
//  WeatherInteractor.swift
//  WeatherVIP
//
//  Created by Olorunshola Godwin on 25/09/2020.
//  Copyright © 2020 Olorunshola Godwin. All rights reserved.
//

import Foundation

protocol  WeatherForecastLogic {
    func fetchWeatherForecast()
    var userInterfaceStyle: UserInterfaceStyle! {get set}
}

class WeatherInteractor: WeatherForecastLogic {
    let locationService: LocationService
    let weatherService: WeatherServiceProtocol
    var presenter: WeatherPresentationLogic
    var userInterfaceStyle: UserInterfaceStyle! {
        didSet {
            presenter.userInterfaceStyle = userInterfaceStyle
        }
    }

    init(presenter: WeatherPresentationLogic, locationService: LocationService = LocationService(),
         weatherService: WeatherServiceProtocol = WeatherService()) {
        self.locationService = locationService
        self.weatherService = weatherService
        self.presenter = presenter
    }

    func fetchWeatherForecast() {
        requestCurrentLocation()
    }

    func requestCurrentLocation() {
        locationService.delegate = self
        locationService.startLocationRequest()
    }

    func fetchCurrentDayWeather(requestBody: ForecastRequest) {
        weatherService.getCurrentDayWeather(requestBody: requestBody) {[weak self] result in
            switch result {
            case .success(let forecast):
                self?.presenter.presentCurrentDayWeather(forecast: forecast)
            case .failure(let error):
                self?.presenter.presentError(error: error.localizedDescription)
            }
        }
    }

    func fetchFivedaysWeather(requestBody: ForecastRequest) {
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
        let requestBody = ForecastRequest(latitude: lat, longitude: lng)
        fetchCurrentDayWeather(requestBody: requestBody)
        fetchFivedaysWeather(requestBody: requestBody)
    }

    func locationdidFail(_ reason: String) {
        presenter.presentError(error: reason)
    }
}
