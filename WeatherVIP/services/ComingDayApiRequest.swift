//
//  ComingDayApiRequest.swift
//  WeatherVIP
//
//  Created by Olorunshola Godwin on 27/09/2020.
//  Copyright © 2020 Olorunshola Godwin. All rights reserved.
//

import Foundation

struct ComingDaysApiRequest: ApiRequest {
    let location: ForecastRequestLocation
    var urlRequest: URLRequest {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.openweathermap.org"
        components.path = "/data/2.5/forecast"
        components.queryItems = [
            URLQueryItem(name: "lat", value: location.latitude),
            URLQueryItem(name: "lon", value: location.longitude),
            URLQueryItem(name: "appid", value: ApiKey.hiddenkey),
            URLQueryItem(name: "units", value: "metric")

        ]
        let url = components.url
        let request = URLRequest(url: url!)
        return request
    }
}
