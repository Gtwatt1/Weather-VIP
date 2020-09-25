//
//  WeatherModel.swift
//  WeatherVIP
//
//  Created by Olorunshola Godwin on 25/09/2020.
//  Copyright © 2020 Olorunshola Godwin. All rights reserved.
//

import Foundation

struct Forecast: Codable {
    let weather: [Weather]?
    let main: Main?
    let dt: Int?
    let timezone: Int?
    let id: Int?
    let name: String?
    let dateString: String?
    enum CodingKeys: String, CodingKey {
        case weather
        case main
        case dt, timezone, id, name
        case dateString = "dt_txt"
    }
}

struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double?
    let pressure, humidity: Int?
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}

struct Weather: Codable {
    let id: Int?
    let main, weatherDescription, icon: String?
    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

enum WeatherType: String {
    case rainy = "rain"
    case sunny = "partlysunny"
    case cloudy = "clear"
}

struct ForecastList: Codable {
    var list: [Forecast]
}

enum Theme: String {
    case forest
    case sea
}
