//
//  WeatherGateway.swift
//  WeatherVIP
//
//  Created by Olorunshola Godwin on 27/09/2020.
//  Copyright © 2020 Olorunshola Godwin. All rights reserved.
//

import Foundation

protocol WeatherGateway {
    func getCurrentDayWeather(requestBody: ForecastRequestLocation?,
                              completion: ((Result<Forecast, Error>) -> Void )?)
    func getFivedaysWeather(requestBody: ForecastRequestLocation?,
                            completion: ((Result<ForecastList, Error>) -> Void)?)
    func fetchCachedWeatherData()
}

extension WeatherGateway {
    func fetchCachedWeatherData() {
        // Making protocol function optional
    }
}
