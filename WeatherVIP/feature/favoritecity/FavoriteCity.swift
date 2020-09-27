//
//  FavoriteCity.swift
//  WeatherVIP
//
//  Created by Olorunshola Godwin on 27/09/2020.
//  Copyright © 2020 Olorunshola Godwin. All rights reserved.
//

import Foundation

struct FavoriteCity: Codable, Equatable {
    let cityName: String
    let temperature: Double
    let lastUpdateDate: Int
    let weatherDescription: String
}
