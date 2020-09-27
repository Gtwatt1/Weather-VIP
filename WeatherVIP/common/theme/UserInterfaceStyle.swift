//
//  UserInterfaceStyle.swift
//  WeatherVIP
//
//  Created by Olorunshola Godwin on 27/09/2020.
//  Copyright © 2020 Olorunshola Godwin. All rights reserved.
//

import Foundation

protocol UserInterfaceStyle {
    func fetchCloudyBackground() -> ViewBackground
    func fetchRainyBackground() -> ViewBackground
    func fetchSunnyBackground() -> ViewBackground
}
