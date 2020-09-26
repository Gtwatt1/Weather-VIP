//
//  WeatherViewModel.swift
//  WeatherVIP
//
//  Created by Olorunshola Godwin on 26/09/2020.
//  Copyright © 2020 Olorunshola Godwin. All rights reserved.
//

import Foundation
typealias CurrentDayForecastVM = WeatherViewModel.CurrentDayForecastVM
typealias ComingDaysForecastVM = WeatherViewModel.ComingDaysForecastVM

typealias WeatherType = WeatherViewModel.WeatherType
typealias Theme = WeatherViewModel.Theme
typealias ViewBackground = WeatherViewModel.ContainerViewBackground

enum WeatherViewModel {
    struct CurrentDayForecastVM {
        let cityName: String
        let weatherDescription: String
        let temperature: String
        let minimalTemperature: String
        let maximalTemperature: String
    }

    struct ComingDaysForecastVM {
        let day: String
        let temperature: String
        let weatherIcon: String
    }

    enum WeatherType: String {
        case rainy = "rain"
        case sunny = "partlysunny"
        case cloudy = "clear"
    }

    enum Theme: String {
        case forest
        case sea
    }

    struct ContainerViewBackground {
        let weatherImage: String
        let backgroundColor: String
    }
}
