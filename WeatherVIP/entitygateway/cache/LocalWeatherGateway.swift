//
//  LocalWeatherGateway.swift
//  WeatherVIP
//
//  Created by Olorunshola Godwin on 27/09/2020.
//  Copyright © 2020 Olorunshola Godwin. All rights reserved.
//

import Foundation
protocol LocalWeatherGateway: WeatherGateway {
    func saveCurrentDayForecast(forecast: Forecast)
    func saveComingDaysForecast(forecastList: ForecastList)
}

class LocalWeatherGatewayImpl: LocalWeatherGateway {

    static let cacheCurrentDayWeather = Notification.Name("didFetchCurrentDayWeather")
    static let cacheComingDaysWeather = Notification.Name("didFetchComingDaysWeather")

    func saveCurrentDayForecast(forecast: Forecast) {
        UserDefaultHelper().save(forecast, key: .currentDayForecast)
    }

    func saveComingDaysForecast(forecastList: ForecastList) {
        UserDefaultHelper().save(forecastList, key: .comingDaysForecast)
    }

    func getCurrentDayWeather(requestBody: ForecastRequestLocation?,
                              completion: ((Result<Forecast, Error>) -> Void)?) {
        if let currentDayForecast = UserDefaultHelper().get(Forecast.self, key: .currentDayForecast) {
            NotificationCenter.default.post(name: LocalWeatherGatewayImpl.cacheCurrentDayWeather,
                                            object: currentDayForecast)
        }
    }

    func getFivedaysWeather(requestBody: ForecastRequestLocation?,
                            completion: ((Result<ForecastList, Error>) -> Void)?) {
        if let currentDayForecast = UserDefaultHelper().get(ForecastList.self, key: .comingDaysForecast) {
            NotificationCenter.default.post(name: LocalWeatherGatewayImpl.cacheComingDaysWeather,
                                            object: currentDayForecast)
        }
    }

    func fetchCachedWeatherData() {
        getFivedaysWeather(requestBody: nil, completion: nil)
        getCurrentDayWeather(requestBody: nil, completion: nil)
    }
}
