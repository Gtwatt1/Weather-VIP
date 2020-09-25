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

    init(locationService: LocationService,weatherService: WeatherServiceProtocol) {
        self.locationService = locationService
        self.weatherService = weatherService
    }

    func fetchWeatherForecast() {
        requestCurrentLocation()
    }

    func requestCurrentLocation() {
        locationService.delegate = self
        locationService.startLocationRequest()
    }
}

extension WeatherInteractor: LocationServiceDelegate {
    func didGetLocation(_ lat: String, lng: String) {
        weatherService.getCurrentDayWeather(lat: lat, lng: lng) {[weak self] (result: Result<Forecast, APIError> ) in
           
        }
        weatherService.getFivedaysWeather(lat: lat, lng: lat) { [weak self] (result: Result<ForecastList, APIError> )  in
           
        }
    }
    func locationdidFail(_ reason: String) {
    }
}
