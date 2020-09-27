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
    let apiClient: ApiClient
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }

    func getCurrentDayWeather(requestBody: ForecastRequestLocation?, completion: ((Result<Forecast, Error>) -> Void)?) {
        guard let requestBody = requestBody, let completion = completion else {
            return
        }
        let currentDayRequest = CurrentDayApiRequest(location: requestBody)
        apiClient.execute(request: currentDayRequest) {(result: Result<Forecast, Error>) in
            completion(result)
        }
    }

    func getFivedaysWeather(requestBody: ForecastRequestLocation?,
                            completion: ((Result<ForecastList, Error>) -> Void)?) {
        guard let requestBody = requestBody, let completion = completion else {
            return
        }
        let comingDaysRequest = ComingDaysApiRequest(location: requestBody)
        apiClient.execute(request: comingDaysRequest) {(result: Result<ForecastList, Error>) in
            completion(result)
        }
    }
}
