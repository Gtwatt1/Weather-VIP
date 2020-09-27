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
    func saveFavoriteCity(_ city: FavoriteCity)
    func getFavoriteCities() -> [FavoriteCity]?
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
        if let currentDayForecast: Forecast = UserDefaultHelper().get(key: .currentDayForecast) {
            NotificationCenter.default.post(name: LocalWeatherGatewayImpl.cacheCurrentDayWeather,
                                            object: currentDayForecast)
        }
    }

    func getFivedaysWeather(requestBody: ForecastRequestLocation?,
                            completion: ((Result<ForecastList, Error>) -> Void)?) {
        if let currentDayForecast: ForecastList = UserDefaultHelper().get(key: .comingDaysForecast) {
            NotificationCenter.default.post(name: LocalWeatherGatewayImpl.cacheComingDaysWeather,
                                            object: currentDayForecast)
        }
    }

    func getFavoriteCities() -> [FavoriteCity]? {
        let favoriteCityList: [FavoriteCity]? =  UserDefaultHelper().get(key: .favoriteCityList)
        return favoriteCityList
    }

    func saveFavoriteCity(_ city: FavoriteCity) {
        if var favoriteCityList = getFavoriteCities() {
            if let index = favoriteCityList.firstIndex(of: city) {
                favoriteCityList.remove(at: index)
            }
            favoriteCityList.append(city)
            UserDefaultHelper().save(favoriteCityList, key: .favoriteCityList)
        } else {
            UserDefaultHelper().save([city], key: .favoriteCityList)
        }
    }

    func fetchCachedWeatherData() {
        getFivedaysWeather(requestBody: nil, completion: nil)
        getCurrentDayWeather(requestBody: nil, completion: nil)
    }
}
