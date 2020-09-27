//
//  DarkModeInterfaceStyleTest.swift
//  WeatherVIPTests
//
//  Created by Olorunshola Godwin on 27/09/2020.
//  Copyright © 2020 Olorunshola Godwin. All rights reserved.
//

import Foundation
import XCTest
@testable import WeatherVIP

class DarkModeInterfaceStyleTest: XCTestCase {
    func test_fetchCloudyBackground_return_forestCloudyImageAndBackground() {
        //arrange
        let sut = DarkModeInterfaceStyle()
        //act
        let background = sut.fetchCloudyBackground()
        //assert
        XCTAssertEqual(background.backgroundColor, ColorName.cloudyBackground)
        XCTAssertEqual(background.weatherImage, ImageName.forestCloudyImage)
    }

    func test_fetchRainyBackground_return_forestRainyImageAndBackground() {
        //arrange
        let sut = DarkModeInterfaceStyle()
        //act
        let background = sut.fetchRainyBackground()
        //assert
        XCTAssertEqual(background.backgroundColor, ColorName.rainyBackground)
        XCTAssertEqual(background.weatherImage, ImageName.forestRainyImage)
    }

    func test_fetchSunnyBackground_return_forestSunnyImageAndBackground() {
        //arrange
        let sut = DarkModeInterfaceStyle()
        //act
        let background = sut.fetchSunnyBackground()
        //assert
        XCTAssertEqual(background.backgroundColor, ColorName.sunnyBackground)
        XCTAssertEqual(background.weatherImage, ImageName.forestSunnyImage)
    }
}
