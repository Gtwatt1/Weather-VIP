//
//  WeatherModel.swift
//  WeatherVIP
//
//  Created by Olorunshola Godwin on 25/09/2020.
//  Copyright © 2020 Olorunshola Godwin. All rights reserved.
//

import Foundation

typealias Forecast = WeatherModelResponse.Forecast
typealias ForecastList = WeatherModelResponse.ForecastList

typealias ForecastRequestLocation = WeatherModelRequest.Body

enum WeatherModelRequest {
    struct Body {
        let latitude: String
        let longitude: String
    }
}

enum WeatherModelResponse {
    struct Forecast: Codable {
        let weather: [Weather]
        let main: Main
        let unixDate: Int
        let forecastID: Int?
        let name: String?
        let dateString: String?
        enum CodingKeys: String, CodingKey {
            case weather
            case main
            case  name
            case forecastID = "id"
            case unixDate = "dt"
            case dateString = "dt_txt"
        }
    }
    struct Main: Codable {
        let temp: Double
        let feelsLike: Double
        let tempMin: Double
        let tempMax: Double
        let pressure: Int
        let humidity: Int
        enum CodingKeys: String, CodingKey {
            case temp
            case feelsLike = "feels_like"
            case tempMin = "temp_min"
            case tempMax = "temp_max"
            case pressure
            case humidity
        }
    }
    struct Weather: Codable {
        let weatherID: Int
        let main: String
        let icon: String
        let weatherDescription: String
        enum CodingKeys: String, CodingKey {
            case main
            case weatherDescription = "description"
            case icon
            case weatherID = "id"
        }
    }

    struct ForecastList: Codable {
        var list: [Forecast]
    }
}
