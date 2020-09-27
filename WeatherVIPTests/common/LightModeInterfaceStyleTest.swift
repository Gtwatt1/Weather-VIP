//
//  LightModeInterfaceStyleTest.swift
//  WeatherVIPTests
//
//  Created by Olorunshola Godwin on 27/09/2020.
//  Copyright © 2020 Olorunshola Godwin. All rights reserved.
//

import Foundation
import XCTest
@testable import WeatherVIP

class LightModeInterfaceStyleTest: XCTestCase {
    func test_fetchCloudyBackground_return_seaCloudyImageAndBackground() {
        //arrange
        let sut = LightModeInterfaceStyle()
        //act
        let background = sut.fetchCloudyBackground()
        //assert
        XCTAssertEqual(background.backgroundColor, ColorName.cloudyBackground)
        XCTAssertEqual(background.weatherImage, ImageName.seaCloudyImage)
    }
    
    func test_fetchRainyBackground_return_seaRainyImageAndBackground() {
        //arrange
        let sut = LightModeInterfaceStyle()
        //act
        let background = sut.fetchRainyBackground()
        //assert
        XCTAssertEqual(background.backgroundColor, ColorName.rainyBackground)
        XCTAssertEqual(background.weatherImage, ImageName.seaRainyImage)
    }

    func test_fetchSunnyBackground_return_seaSunnyImageAndBackground() {
        //arrange
        let sut = LightModeInterfaceStyle()
        //act
        let background = sut.fetchSunnyBackground()
        //assert
        XCTAssertEqual(background.backgroundColor, ColorName.sunnyBackground)
        XCTAssertEqual(background.weatherImage, ImageName.seaSunnyImage)
    }
}
