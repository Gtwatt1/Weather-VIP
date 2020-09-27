//
//  WeatherPresenterTest.swift
//  WeatherVIPTests
//
//  Created by Olorunshola Godwin on 27/09/2020.
//  Copyright © 2020 Olorunshola Godwin. All rights reserved.
//

import Foundation
import XCTest
@testable import WeatherVIP

class WeatherPresenterTest: XCTestCase {
    let jsonDecodingError = "Json decoding failed"
    var sut: WeatherPresenter!
    let interfaceStyle = LightModeInterfaceStyle()
    let mockView = MockWeatherView()

    override func setUp() {
        sut = WeatherPresenter()
    }

    func test_view_initialized_when_setViewCalled() {
        //act
        sut.setView(view: mockView )
        //assert
        XCTAssertNotNil(sut.view)
    }

    func test_getWeatherBackground_returnCloudyBackground_when_weatherDescription_containscloud() {
        //arrange
        sut.userInterfaceStyle = interfaceStyle
        let mainWeatherDescription = "Clouds"
        //act
        let weatherBackground = sut.getWeatherBackground(mainWeatherDescription)
        //assert
        XCTAssertEqual(weatherBackground.backgroundColor, interfaceStyle.fetchCloudyBackground().backgroundColor)
        XCTAssertEqual(weatherBackground.weatherImage, interfaceStyle.fetchCloudyBackground().weatherImage)
    }
    func test_getWeatherBackground_returnRainyBackground_when_weatherDescription_containsRain() {
        //arrange
        sut.userInterfaceStyle = interfaceStyle
        let mainWeatherDescription = "Rain"
        //act
        let weatherBackground = sut.getWeatherBackground(mainWeatherDescription)
        //assert
        XCTAssertEqual(weatherBackground.backgroundColor, interfaceStyle.fetchRainyBackground().backgroundColor)
        XCTAssertEqual(weatherBackground.weatherImage, interfaceStyle.fetchRainyBackground().weatherImage)
    }
    func test_getWeatherBackground_returnSunnyBackground_when_weatherDescription_isSun() {
        //arrange
        sut.userInterfaceStyle = interfaceStyle
        let mainWeatherDescription = "Clear"
        //act
        let weatherBackground = sut.getWeatherBackground(mainWeatherDescription)
        //assert
        XCTAssertEqual(weatherBackground.backgroundColor, interfaceStyle.fetchSunnyBackground().backgroundColor)
        XCTAssertEqual(weatherBackground.weatherImage, interfaceStyle.fetchSunnyBackground().weatherImage)
    }
    func test_getDayOfTheWeek_returns_correct_Day() {
        //act
        let day = sut.getDayOfTheWeek(intDate: 1601203953)
        //assert
        XCTAssertEqual(day, "Sunday")
    }
    func test_currentDayViewModelMapping_return_correct_currentDayForecastVM() {
        //arrange
        if let forecast = Seeds.forecast {
            //act
            let viewModel = sut.currentDayViewModelMapping(forecast: forecast)
            //assert
            XCTAssertEqual(viewModel.cityName, forecast.name)
            XCTAssertEqual(viewModel.weatherDescription, forecast.weather[0].weatherDescription.capitalized)
            XCTAssertEqual(viewModel.temperature, "\(forecast.main.temp)" + "º")
            XCTAssertEqual(viewModel.minimalTemperature, "\(forecast.main.tempMin)" + "º")
            XCTAssertEqual(viewModel.maximalTemperature, "\(forecast.main.tempMax)" + "º")
        } else {
            XCTFail(jsonDecodingError)
        }
    }
    func test_comingDaysViewModelMapping_return_correct_comingDaysForecastVM() {
        //arrange
        if let forecastList = Seeds.forecastList {
            //act
            let viewModels = sut.comingDaysViewModelMapping(forecasts: forecastList.list)
            let firstVm = viewModels.first
            //assert
            XCTAssertEqual(firstVm?.day, "Tuesday")
            XCTAssertEqual(firstVm?.weatherIcon, "rain")
            XCTAssertEqual(firstVm?.temperature, "293.55º")
        } else {
            XCTFail(jsonDecodingError)
        }
    }
    func test_filterEarlyMorningForecast_returns_only_morningWeatherData() {
        //arrange
        if let forecastList = Seeds.forecastList {
            //act
            let viewModels = sut.filterEarlyMorningForecast(forecastList.list)
            //assert
            XCTAssertEqual(viewModels.count, 1)
        } else {
            XCTFail(jsonDecodingError)
        }
    }
    func test_presentCurrentDayWeather_called_view_displayCurrentDayWeather() {
        //arrange
        sut.setView(view: mockView)
        sut.userInterfaceStyle = LightModeInterfaceStyle()
        if let forecast = Seeds.forecast {
            //act
            sut.presentCurrentDayWeather(forecast: forecast)
            //assert
            XCTAssertTrue(mockView.displayCurrentDayWeatherCalled)
        } else {
            XCTFail(jsonDecodingError)
        }
    }
    func test_presentCurrentDayWeather_called_view_displayViewBackground() {
        //arrange
        sut.setView(view: mockView)
        sut.userInterfaceStyle = LightModeInterfaceStyle()
        if let forecast = Seeds.forecast {
            //act
            sut.presentCurrentDayWeather(forecast: forecast)
            //assert
            XCTAssertTrue(mockView.displayViewBackgroundCalled)
        } else {
            XCTFail(jsonDecodingError)
        }
    }
    func test_presentFiveDaysWeather_called_view_displayComingDaysWeather() {
        //arrange
        sut.setView(view: mockView)
        sut.userInterfaceStyle = LightModeInterfaceStyle()
        if let forecastList = Seeds.forecastList {
            //act
            sut.presentFiveDaysWeather(forecastList: forecastList)
            //assert
            XCTAssertTrue(mockView.displayComingDaysWeatherCalled)
        } else {
            XCTFail(jsonDecodingError)
        }
    }
    func test_presentError_called_view_displayError() {
        //arrange
        sut.setView(view: mockView)
        //act
        sut.presentError(error: "An error")
        //assert
        XCTAssertTrue(mockView.displayErrorCalled)
    }
}

class MockWeatherView: WeatherDisplayLogic {
    var displayCurrentDayWeatherCalled = false
    var displayViewBackgroundCalled = false
    var displayComingDaysWeatherCalled = false
    var displayErrorCalled = false
    func displayCurrentDayWeather(viewModel: CurrentDayForecastVM) {
        displayCurrentDayWeatherCalled = true
    }
    func displayViewBackground(_ background: ViewBackground) {
        displayViewBackgroundCalled = true
    }
    func displayComingDaysWeather(cellRepresentable: [ComingDaysForecastVM]) {
        displayComingDaysWeatherCalled = true
    }
    func displayError(_ error: String) {
        displayErrorCalled = true
    }
}
