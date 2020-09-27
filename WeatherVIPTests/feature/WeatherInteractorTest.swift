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
    func test_fetchCurrentDayWeather_calls_presenter_presentCurrentDayWeather_when_weatherService_succeed() {
        //arrange
        let mockPresenter = MockPresenter()
        let apiClient = APIClientImplementation()
        let mockService = MockWeatherService(localWeatherGateway: LocalWeatherGatewayImpl(),
                                             apiWeatherGateway: ApiWeatherGatewayImpl(apiClient: apiClient))
        mockService.returnSuccess = true
        let mockLocationService = LocationService()
        let sut = WeatherInteractor(presenter: mockPresenter, locationService: mockLocationService,
                                    weatherService: mockService)
        let requestLocation = ForecastRequestLocation(latitude: "0", longitude: "0")
        //act
        sut.fetchCurrentDayWeather(requestBody: requestLocation)
        //assert
        XCTAssertTrue(mockPresenter.presentCurrentDayWeatherCalled)
    }

    func test_fetchCurrentDayWeather_calls_presenter_presentError_when_weatherService_fails() {
        //arrange
        let mockPresenter = MockPresenter()
        let apiClient = APIClientImplementation()
        let mockService = MockWeatherService(localWeatherGateway: LocalWeatherGatewayImpl(),
                                             apiWeatherGateway: ApiWeatherGatewayImpl(apiClient: apiClient))
        let mockLocationService = LocationService()
        let sut = WeatherInteractor(presenter: mockPresenter, locationService: mockLocationService,
                                    weatherService: mockService)
        let requestLocation = ForecastRequestLocation(latitude: "0", longitude: "0")
        //act
        sut.fetchCurrentDayWeather(requestBody: requestLocation)
        //assert
        XCTAssertTrue(mockPresenter.presentErrorCalled)
    }

    func test_fetchComingDaysWeather_calls_presenter_presentFiveDaysWeather_when_weatherService_succeed() {
        //arrange
        let mockPresenter = MockPresenter()
        let apiClient = APIClientImplementation()
        let mockService = MockWeatherService(localWeatherGateway: LocalWeatherGatewayImpl(),
                                             apiWeatherGateway: ApiWeatherGatewayImpl(apiClient: apiClient))
        mockService.returnSuccess = true
        let mockLocationService = LocationService()
        let sut = WeatherInteractor(presenter: mockPresenter,
                                    locationService: mockLocationService, weatherService: mockService)
        let requestLocation = ForecastRequestLocation(latitude: "0", longitude: "0")
        //act
        sut.fetchFivedaysWeather(requestBody: requestLocation)
        //assert
        XCTAssertTrue(mockPresenter.presentComingDaysWeatherCalled)
    }

    func test_fetchComingDaysWeather_calls_presenter_presentError_when_weatherService_fails() {
        //arrange
        let mockPresenter = MockPresenter()
        let apiClient = APIClientImplementation()
        let mockService = MockWeatherService(localWeatherGateway: LocalWeatherGatewayImpl(),
                                             apiWeatherGateway: ApiWeatherGatewayImpl(apiClient: apiClient))
        let mockLocationService = LocationService()
        let sut = WeatherInteractor(presenter: mockPresenter, locationService: mockLocationService,
                                    weatherService: mockService)
        let requestLocation = ForecastRequestLocation(latitude: "0", longitude: "0")
        //act
        sut.fetchFivedaysWeather(requestBody: requestLocation)
        //assert
        XCTAssertTrue(mockPresenter.presentErrorCalled)
    }

    func test_didGetLocation_calls_weatherService_fetchCurrentDayWeather() {
        //arrange
        let mockPresenter = MockPresenter()
        let apiClient = APIClientImplementation()
        let mockService = MockWeatherService(localWeatherGateway: LocalWeatherGatewayImpl(),
                                             apiWeatherGateway: ApiWeatherGatewayImpl(apiClient: apiClient))
        let mockLocationService = LocationService()
        let sut = WeatherInteractor(presenter: mockPresenter, locationService: mockLocationService,
                                    weatherService: mockService)
        //act
        sut.didGetLocation("0", lng: "0")
        //assert
        XCTAssertTrue(mockService.fetchCurrentDayWeatherCalled)
    }

    func test_didGetLocation_calls_weatherService_fetchComingDaysWeather() {
        //arrange
        let mockPresenter = MockPresenter()
        let apiClient = APIClientImplementation()
        let mockService = MockWeatherService(localWeatherGateway: LocalWeatherGatewayImpl(),
                                             apiWeatherGateway: ApiWeatherGatewayImpl(apiClient: apiClient))
        let mockLocationService = LocationService()
        let sut = WeatherInteractor(presenter: mockPresenter, locationService: mockLocationService,
                                    weatherService: mockService)
        //act
        sut.didGetLocation("0", lng: "0")
        //assert
        XCTAssertTrue(mockService.fetchFivedaysWeatherCalled)
    }

    func test_locationdidFail_calls_presenter_presentError() {
        //arrange
        let mockPresenter = MockPresenter()
        let apiClient = APIClientImplementation()
        let mockService = MockWeatherService(localWeatherGateway: LocalWeatherGatewayImpl(),
                                             apiWeatherGateway: ApiWeatherGatewayImpl(apiClient: apiClient))
        let mockLocationService = LocationService()
        let sut = WeatherInteractor(presenter: mockPresenter, locationService: mockLocationService,
                                    weatherService: mockService)
        //act
        sut.didGetLocation("0", lng: "0")
        //assert
        XCTAssertTrue(mockPresenter.presentErrorCalled)
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

class MockWeatherService: WeatherService {
    var returnSuccess = false
    var fetchCurrentDayWeatherCalled = false
    var fetchFivedaysWeatherCalled = false

    override func getCurrentDayWeather(requestBody: ForecastRequestLocation?,
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

    override func getFivedaysWeather(requestBody: ForecastRequestLocation?,
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
}
