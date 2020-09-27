//
//  WeatherServiceTest.swift
//  WeatherVIPTests
//
//  Created by Olorunshola Godwin on 27/09/2020.
//  Copyright © 2020 Olorunshola Godwin. All rights reserved.
//

import Foundation
import XCTest
@testable import WeatherVIP

class WeatherServiceTest: XCTestCase {
    var sut: WeatherService!
    let localWeatherGateway = MockLocalWeatherGateWay()
    let apiWeatherGateway = MockApiWeatherGateway()
    let requestBody = ForecastRequestLocation(latitude: "0", longitude: "0")

    override func setUp() {
        sut = WeatherService(localWeatherGateway: localWeatherGateway, apiWeatherGateway: apiWeatherGateway)
    }

    func test_getCurrentDayWeather_success_savesCurrentDayForecast() {
        //arrange
        let exp = expectation(description: "get current day weather expectation")
        //act
        sut.getCurrentDayWeather(requestBody: requestBody) { _ in
            //assert
            XCTAssertTrue(self.localWeatherGateway.saveCurrentDayForecastCalled)
            exp.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }

    func test_getCurrentDayWeather_success_savesComingDaysForecast() {
        //arrange
        let exp = expectation(description: "get current day weather expectation")
        //act
        sut.getFivedaysWeather(requestBody: requestBody) { _ in
            //assert
            XCTAssertTrue(self.localWeatherGateway.saveComingDaysForecastCalled)
            exp.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
}

class MockLocalWeatherGateWay: LocalWeatherGateway {
    var saveCurrentDayForecastCalled = false
    var saveComingDaysForecastCalled = false

    func saveCurrentDayForecast(forecast: Forecast) {
        saveCurrentDayForecastCalled = true
    }

    func saveComingDaysForecast(forecastList: ForecastList) {
        saveComingDaysForecastCalled = true
    }

    func getCurrentDayWeather(requestBody: ForecastRequestLocation?, completion: ((Result<Forecast, Error>) -> Void)?) {
        // Implementation not needed here
    }

    func getFivedaysWeather(requestBody: ForecastRequestLocation?,
                            completion: ((Result<ForecastList, Error>) -> Void)?) {
        // Implementation not needed here
    }
}

class MockApiWeatherGateway: ApiWeatherGateway {
    func getCurrentDayWeather(requestBody: ForecastRequestLocation?, completion: ((Result<Forecast, Error>) -> Void)?) {
        if let forecast = Seeds.forecast, let completion = completion {
            completion(.success(forecast))
        }
    }

    func getFivedaysWeather(requestBody: ForecastRequestLocation?,
                            completion: ((Result<ForecastList, Error>) -> Void)?) {
        if let forecast = Seeds.forecastList, let completion = completion {
            completion(.success(forecast))
        }
    }
}
