//
//  WeatherHelperTest.swift
//  WeatherVIPTests
//
//  Created by Olorunshola Godwin on 28/09/2020.
//  Copyright © 2020 Olorunshola Godwin. All rights reserved.
//

import Foundation
import XCTest
@testable import WeatherVIP

class WeatherHelperTest: XCTestCase {
    var sut: WeatherHelper!

    override func setUp() {
        sut = WeatherHelper()
    }

    func test_getWeatherType_returnCloudy_when_weatherDescription_containscloud() {
        //arrange
        let mainWeatherDescription = "Clouds"
        //act
        let weatherType = sut.getWeatherType(mainWeatherDescription)
        //assert
        XCTAssertEqual(weatherType, WeatherType.cloudy)
    }
    func test_getWeatherType_returnRain_when_weatherDescription_containsRain() {
        //arrange
        let mainWeatherDescription = "Rain"
        //act
        let weatherType = sut.getWeatherType(mainWeatherDescription)
        //assert
        XCTAssertEqual(weatherType, WeatherType.rainy)
    }
    func test_getWeatherType_returnSunny_when_weatherDescription_isSun() {
        //arrange
        let mainWeatherDescription = "Clear"
        //act
        let weatherType = sut.getWeatherType(mainWeatherDescription)
        //assert
        XCTAssertEqual(weatherType, WeatherType.sunny)
    }
}
