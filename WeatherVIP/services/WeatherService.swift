//
//  WeatherService.swift
//  WeatherVIP
//
//  Created by Olorunshola Godwin on 27/09/2020.
//  Copyright © 2020 Olorunshola Godwin. All rights reserved.
//

import Foundation

class WeatherService: WeatherGateway {

    let localWeatherGateway: LocalWeatherGateway
    let apiWeatherGateway: ApiWeatherGateway

    init(localWeatherGateway: LocalWeatherGateway, apiWeatherGateway: ApiWeatherGateway) {
        self.apiWeatherGateway =  apiWeatherGateway
        self.localWeatherGateway = localWeatherGateway
    }

    func getCurrentDayWeather(requestBody: ForecastRequestLocation?, completion: ((Result<Forecast, Error>) -> Void)?) {
        guard let requestBody = requestBody, let completion = completion else {
            return
        }
        apiWeatherGateway.getCurrentDayWeather(requestBody: requestBody) { [weak self](result) in
            switch result {
            case .success(let forecast):
                self?.localWeatherGateway.saveCurrentDayForecast(forecast: forecast)
            default:
                break
            }
            completion(result)
        }
    }

    func getFivedaysWeather(requestBody: ForecastRequestLocation?,
                            completion: ((Result<ForecastList, Error>) -> Void)?) {
        guard let requestBody = requestBody, let completion = completion else {
            return
        }
        apiWeatherGateway.getFivedaysWeather(requestBody: requestBody) { [weak self](result) in
            switch result {
            case .success(let forecastList):
                self?.localWeatherGateway.saveComingDaysForecast(forecastList: forecastList)
            default:
                break
            }
            completion(result)
        }
    }

    func fetchCachedWeatherData() {
        localWeatherGateway.fetchCachedWeatherData()
    }

    func saveFavoriteCity(_ city: FavoriteCity) {
        localWeatherGateway.saveFavoriteCity(city)
    }
}
