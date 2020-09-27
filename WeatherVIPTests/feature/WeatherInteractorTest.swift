//
//  WeatherInteractorTest.swift
//  WeatherVIPTests
//
//  Created by Olorunshola Godwin on 27/09/2020.
//  Copyright © 2020 Olorunshola Godwin. All rights reserved.
//

import Foundation

import XCTest
@testable import WeatherVIP

class WeatherInteractorTest: XCTestCase {
    let mockPresenter = MockPresenter()
    var mockWeatherService: MockWeatherService!
    let mockLocationService = LocationService()

    override func setUp() {
        mockWeatherService = MockWeatherService()
    }

    func test_fetchCurrentDayWeather_calls_presenter_presentCurrentDayWeather_when_weatherService_succeed() {
        //arrange
        mockWeatherService.returnSuccess = true
        let sut = WeatherInteractor(presenter: mockPresenter, locationService: mockLocationService,
                                    weatherService: mockWeatherService)
        let requestLocation = ForecastRequestLocation(latitude: "0", longitude: "0")
        //act
        sut.fetchCurrentDayWeather(requestBody: requestLocation)
        //assert
        XCTAssertTrue(mockPresenter.presentCurrentDayWeatherCalled)
    }

    func test_fetchCurrentDayWeather_calls_presenter_presentError_when_weatherService_fails() {
        //arrange
        let sut = WeatherInteractor(presenter: mockPresenter, locationService: mockLocationService,
                                    weatherService: mockWeatherService)
        let requestLocation = ForecastRequestLocation(latitude: "0", longitude: "0")
        //act
        sut.fetchCurrentDayWeather(requestBody: requestLocation)
        //assert
        XCTAssertTrue(mockPresenter.presentErrorCalled)
    }

    func test_fetchComingDaysWeather_calls_presenter_presentFiveDaysWeather_when_weatherService_succeed() {
        //arrange
        mockWeatherService.returnSuccess = true
        let sut = WeatherInteractor(presenter: mockPresenter,
                                    locationService: mockLocationService, weatherService: mockWeatherService)
        let requestLocation = ForecastRequestLocation(latitude: "0", longitude: "0")
        //act
        sut.fetchFivedaysWeather(requestBody: requestLocation)
        //assert
        XCTAssertTrue(mockPresenter.presentComingDaysWeatherCalled)
    }

    func test_fetchComingDaysWeather_calls_presenter_presentError_when_weatherService_fails() {
        //arrange
        let sut = WeatherInteractor(presenter: mockPresenter, locationService: mockLocationService,
                                    weatherService: mockWeatherService)
        let requestLocation = ForecastRequestLocation(latitude: "0", longitude: "0")
        //act
        sut.fetchFivedaysWeather(requestBody: requestLocation)
        //assert
        XCTAssertTrue(mockPresenter.presentErrorCalled)
    }

    func test_didGetLocation_calls_weatherService_fetchCurrentDayWeather() {
        //arrange
        let sut = WeatherInteractor(presenter: mockPresenter, locationService: mockLocationService,
                                    weatherService: mockWeatherService)
        //act
        sut.didGetLocation("0", lng: "0")
        //assert
        XCTAssertTrue(mockWeatherService.fetchCurrentDayWeatherCalled)
    }

    func test_didGetLocation_calls_weatherService_fetchComingDaysWeather() {
        //arrange
        let sut = WeatherInteractor(presenter: mockPresenter, locationService: mockLocationService,
                                    weatherService: mockWeatherService)
        //act
        sut.didGetLocation("0", lng: "0")
        //assert
        XCTAssertTrue(mockWeatherService.fetchFivedaysWeatherCalled)
    }

    func test_locationdidFail_calls_presenter_presentError() {
        //arrange
        let sut = WeatherInteractor(presenter: mockPresenter, locationService: mockLocationService,
                                    weatherService: mockWeatherService)
        //act
        sut.didGetLocation("0", lng: "0")
        //assert
        XCTAssertTrue(mockPresenter.presentErrorCalled)
    }

    func test_fetch_cachedWeatherData_calls_weatherService_fetchCachedWeatherData() {
        //arrange
        let sut = WeatherInteractor(presenter: mockPresenter, locationService: mockLocationService,
                                    weatherService: mockWeatherService)
        //act
        sut.fetchCachedWeatherData()
        //assert
        XCTAssertTrue(mockWeatherService.fetchCachedWeatherDataCalled)
    }
}

class MockPresenter: WeatherPresentationLogic {
    var presentCurrentDayWeatherCalled = false
    var presentComingDaysWeatherCalled = false
    var presentErrorCalled = false

    func presentCurrentDayWeather(forecast: Forecast) {
        presentCurrentDayWeatherCalled = true
    }

    func presentFiveDaysWeather(forecastList: ForecastList) {
        presentComingDaysWeatherCalled = true
    }

    func presentError(error: String) {
        presentErrorCalled = true
    }

    var userInterfaceStyle: UserInterfaceStyle!
}

class MockWeatherService: WeatherGateway {
    var returnSuccess = false
    var fetchCurrentDayWeatherCalled = false
    var fetchFivedaysWeatherCalled = false
    var fetchCachedWeatherDataCalled = false

    func getCurrentDayWeather(requestBody: ForecastRequestLocation?,
                              completion: ((Result<Forecast, Error>) -> Void)?) {
        fetchCurrentDayWeatherCalled = true
        if let completion = completion {
            if returnSuccess {
                if  let forecast = Seeds.forecast {
                    completion(.success(forecast))
                }
            } else {
                completion(.failure(APIError.requestFailed))
            }
        }
    }

    func getFivedaysWeather(requestBody: ForecastRequestLocation?,
                            completion: ((Result<ForecastList, Error>) -> Void)?) {
        fetchFivedaysWeatherCalled = true
        if let completion = completion {
            if returnSuccess {
                if  let forecastList = Seeds.forecastList {
                    completion(.success(forecastList))
                }
            } else {
                completion(.failure(APIError.requestFailed))
            }
        }
    }
    func fetchCachedWeatherData() {
       fetchCachedWeatherDataCalled = true
    }
}
