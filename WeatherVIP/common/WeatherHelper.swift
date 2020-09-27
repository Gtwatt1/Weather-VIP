//
//  WeatherHelper.swift
//  WeatherVIP
//
//  Created by Olorunshola Godwin on 28/09/2020.
//  Copyright © 2020 Olorunshola Godwin. All rights reserved.
//

import Foundation

class WeatherHelper {
    func getWeatherType(_ weatherName: String) -> WeatherType {
        switch weatherName.lowercased() {
        case let value where WeatherConstants.rainyWeatherType.contains(value):
            return WeatherType.rainy
        case let value where value.contains("cloud"):
            return WeatherType.cloudy
        default:
            return WeatherType.sunny
        }
    }

    func decorateWithTemperatureDegree(_ value: Double) -> String {
        return "\(value)º"
    }

    func unixDateToStringDate(unix: Int) -> String {
        let date = Date(timeIntervalSince1970: Double(unix))
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: date)
    }

}
