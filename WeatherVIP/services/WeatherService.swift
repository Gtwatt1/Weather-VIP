//
//  WeatherService.swift
//  Weather
//
//  Created by Godwin Olorunshola on 11/12/2019.
//  Copyright © 2019 Godwin Olorunshola. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherServiceProtocol {
    func getCurrentDayWeather(requestBody: ForecastRequest,
                              completion: @escaping (Result<Forecast, APIError>) -> Void )
    func getFivedaysWeather(requestBody: ForecastRequest,
                            completion: @escaping (Result<ForecastList, APIError>) -> Void)
}

class WeatherService: WeatherServiceProtocol {
    func getCurrentDayWeather(requestBody: ForecastRequest,
                              completion: @escaping (Result<Forecast, APIError>) -> Void) {
        let url = String(format: URLConstants.getCurrentForcast, requestBody.latitude, requestBody.longitude)
        Networker.shared.makeGetRequest(url: url) {(result: Result<Forecast, APIError>) in
            completion(result)
        }
    }

    func getFivedaysWeather(requestBody: ForecastRequest,
                            completion: @escaping (Result< ForecastList, APIError>) -> Void) {
        let url = String(format: URLConstants.getFiveDaysForecast, requestBody.latitude, requestBody.longitude)
        Networker.shared.makeGetRequest(url: url) {(result: Result<ForecastList, APIError>) in
            completion(result)
        }
    }
}
