//
//  LightModeInterfaceStyle.swift
//  WeatherVIP
//
//  Created by Olorunshola Godwin on 27/09/2020.
//  Copyright © 2020 Olorunshola Godwin. All rights reserved.
//

import Foundation
class LightModeInterfaceStyle: UserInterfaceStyle {
    func fetchCloudyBackground() -> ViewBackground {
        return ViewBackground(weatherImage: ImageName.seaCloudyImage, backgroundColor: ColorName.cloudyBackground)
    }

    func fetchRainyBackground() -> ViewBackground {
        return ViewBackground(weatherImage: ImageName.seaRainyImage, backgroundColor: ColorName.rainyBackground)

    }
    func fetchSunnyBackground() -> ViewBackground {
        return ViewBackground(weatherImage: ImageName.seaSunnyImage, backgroundColor: ColorName.sunnyBackground)
    }
}
