//
//  DarkModeInterfaceStyle.swift
//  WeatherVIP
//
//  Created by Olorunshola Godwin on 27/09/2020.
//  Copyright © 2020 Olorunshola Godwin. All rights reserved.
//

import Foundation

class DarkModeInterfaceStyle: UserInterfaceStyle {
    func fetchCloudyBackground() -> ViewBackground {
        return ViewBackground(weatherImage: ImageName.forestCloudyImage, backgroundColor: ColorName.cloudyBackground)
    }

    func fetchRainyBackground() -> ViewBackground {
        return ViewBackground(weatherImage: ImageName.forestRainyImage, backgroundColor: ColorName.rainyBackground)
    }

    func fetchSunnyBackground() -> ViewBackground {
        return ViewBackground(weatherImage: ImageName.forestSunnyImage, backgroundColor: ColorName.sunnyBackground)
    }
}
