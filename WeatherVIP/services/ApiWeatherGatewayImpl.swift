//
//  WeatherService.swift
//  Weather
//
//  Created by Godwin Olorunshola on 11/12/2019.
//  Copyright © 2019 Godwin Olorunshola. All rights reserved.
//

import Foundation

protocol ApiWeatherGateway: WeatherGateway {
}

class ApiWeatherGatewayImpl: ApiWeatherGateway {
    func getCurrentDayWeather(requestBody: ForecastRequestLocation?, completion: ((Result<Forecast, Error>) -> Void)?) {
        guard let requestBody = requestBody, let completion = completion else {
            return
        }
        let url = String(format: URLConstants.getCurrentForcast, requestBody.latitude, requestBody.longitude)
        Networker.shared.makeGetRequest(url: url) {(result: Result<Forecast, Error>) in
            completion(result)
        }
    }

    func getFivedaysWeather(requestBody: ForecastRequestLocation?,
                            completion: ((Result<ForecastList, Error>) -> Void)?) {
        guard let requestBody = requestBody, let completion = completion else {
            return
        }
        let url = String(format: URLConstants.getFiveDaysForecast, requestBody.latitude, requestBody.longitude)
        Networker.shared.makeGetRequest(url: url) {(result: Result<ForecastList, Error>) in
            completion(result)
        }
    }
}
