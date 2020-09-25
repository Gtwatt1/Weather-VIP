//
//  UrlConstants.swift
//  Weather
//
//  Created by Godwin Olorunshola on 12/12/2019.
//  Copyright © 2019 Godwin Olorunshola. All rights reserved.
//

import Foundation

enum URLConstants {
    static var getCurrentForcast = "https://api.openweathermap.org/data/2.5/weather?lat=%@&lon=%@&appid=\(apiKey)&units=metric"
    static var getFiveDaysForecast = "https://api.openweathermap.org/data/2.5/forecast?lat=%@&lon=%@&appid=\(apiKey)&units=metric"
    static var apiKey = "1bb48b9b6bd17cea1ac470e2bee6ab09"
}
