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
}

class WeatherInteractor: WeatherForecastLogic {
    let locationService: LocationService
    let weatherService: WeatherServiceProtocol
    let presenter: WeatherPresentationLogic

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

    func fetchCurrentDayWeather(_ lat: String, lng: String) {
        weatherService.getCurrentDayWeather(lat: lat, lng: lng) {[weak self] (result: Result<Forecast, APIError> ) in

        }
    }

    func fetchFivedaysWeather(_ lat: String, lng: String) {
        weatherService.getFivedaysWeather(lat: lat, lng: lat) { [weak self] (result: Result<ForecastList, APIError> )  in

        }
    }
}

extension WeatherInteractor: LocationServiceDelegate {
    func didGetLocation(_ lat: String, lng: String) {
        fetchCurrentDayWeather(lat, lng: lng)
        fetchFivedaysWeather(lat, lng: lng)
    }

    func locationdidFail(_ reason: String) {

    }
}
