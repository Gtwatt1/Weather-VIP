//
//  ApiWeatherGatewayImplTest.swift
//  WeatherVIPTests
//
//  Created by Olorunshola Godwin on 27/09/2020.
//  Copyright © 2020 Olorunshola Godwin. All rights reserved.
//

import Foundation
import XCTest
@testable import WeatherVIP

class ApiWeatherGatewayImplTest: XCTestCase {
    var sut: ApiWeatherGatewayImpl!
    var mockApiClient: MockApiClient!
    let mockRequestLocation = ForecastRequestLocation(latitude: "0", longitude: "0")

    override func setUp() {
        mockApiClient = MockApiClient()
        sut = ApiWeatherGatewayImpl(apiClient: mockApiClient)
    }

    func test_getCurrentDayWeather_calls_apiClient_withCorrectRequest() {
        //arrange
        let expectedRequestLocation = CurrentDayApiRequest(location: mockRequestLocation)
        let exp = expectation(description: "Waiting for currentDayWeather")
        //act
        sut.getCurrentDayWeather(requestBody: mockRequestLocation) { _ in
            //assert
            XCTAssertEqual(self.mockApiClient.request?.urlRequest, expectedRequestLocation.urlRequest)
            exp.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }

    func test_getFivedaysWeather_calls_apiClient_withCorrectRequest() {
        //arrange
        let expectedRequestLocation = ComingDaysApiRequest(location: mockRequestLocation)
        let exp = expectation(description: "Waiting for currentDayWeather")
        //act
        sut.getFivedaysWeather(requestBody: mockRequestLocation) { _ in
            //assert
            XCTAssertEqual(self.mockApiClient.request?.urlRequest, expectedRequestLocation.urlRequest)
            exp.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
}

class MockApiClient: ApiClient {
    var request: ApiRequest?
    func execute<T>(request: ApiRequest, completion: @escaping (Result<T, Error>) -> Void) where T: Decodable {
        self.request = request
        completion(.failure(APIError.requestFailed))
    }
}
