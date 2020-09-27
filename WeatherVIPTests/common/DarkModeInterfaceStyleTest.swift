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
    var sut: DarkModeInterfaceStyle!

    override func setUp() {
         sut = DarkModeInterfaceStyle()
    }

    func test_fetchCloudyBackground_return_forestCloudyImageAndBackground() {
        //act
        let background = sut.fetchCloudyBackground()
        //assert
        XCTAssertEqual(background.backgroundColor, ColorName.cloudyBackground)
        XCTAssertEqual(background.weatherImage, ImageName.forestCloudyImage)
    }

    func test_fetchRainyBackground_return_forestRainyImageAndBackground() {
        //act
        let background = sut.fetchRainyBackground()
        //assert
        XCTAssertEqual(background.backgroundColor, ColorName.rainyBackground)
        XCTAssertEqual(background.weatherImage, ImageName.forestRainyImage)
    }

    func test_fetchSunnyBackground_return_forestSunnyImageAndBackground() {
        //act
        let background = sut.fetchSunnyBackground()
        //assert
        XCTAssertEqual(background.backgroundColor, ColorName.sunnyBackground)
        XCTAssertEqual(background.weatherImage, ImageName.forestSunnyImage)
    }
}
