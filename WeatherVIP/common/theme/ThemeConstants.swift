//
//  ThemeConstants.swift
//  WeatherVIP
//
//  Created by Olorunshola Godwin on 26/09/2020.
//  Copyright © 2020 Olorunshola Godwin. All rights reserved.
//

import Foundation

typealias ColorName = ThemeConstant.ColorNames
typealias ImageName = ThemeConstant.ImageNames

enum ThemeConstant {
    enum ColorNames {
        static let cloudyBackground = "cloudyBackground"
        static let rainyBackground = "rainyBackground"
        static let sunnyBackground = "sunnyBackground"
    }

    enum ImageNames {
        static let forestCloudyImage = "forest_cloudy"
        static let forestSunnyImage = "forest_sunny"
        static let forestRainyImage = "forest_rainy"
        static let seaCloudyImage = "sea_cloudy"
        static let seaSunnyImage = "sea_sunny"
        static let seaRainyImage = "sea_rainy"
    }
}
