//
//  ApiClientTest.swift
//  WeatherVIPTests
//
//  Created by Olorunshola Godwin on 27/09/2020.
//  Copyright © 2020 Olorunshola Godwin. All rights reserved.
//

import Foundation
import XCTest
@testable import WeatherVIP

class ApiClientTest: XCTestCase {
    let expectationMessage = "waiting for dataTask response"
    func test_apiClientExecute_returns_error_when_dataTaskReturnsError() {
        //arrange
        let mockUrlSession = MockURLSession()
        mockUrlSession.returnError = true
        let sut = APIClientImplementation(urlSession: mockUrlSession)
        let mockRequest = CurrentDayApiRequest(location: ForecastRequestLocation(latitude: "0", longitude: "0"))
        let exp = expectation(description: expectationMessage)
        //act
        sut.execute(request: mockRequest) { (result: Result<MockSuccessObject, Error> ) in
            switch result {
            case .failure(let err):
                //assert
                XCTAssertEqual(err.localizedDescription, APIError.requestFailed.localizedDescription)
                exp.fulfill()
            case .success:
                break
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
    }

    func test_apiClientExecute_returns_object_when_dataTaskReturnsCorrectData() {
        //arrange
        let mockUrlSession = MockURLSession()
        mockUrlSession.return200 = true
        let sut = APIClientImplementation(urlSession: mockUrlSession)
        let mockRequest = CurrentDayApiRequest(location: ForecastRequestLocation(latitude: "0", longitude: "0"))
        let exp = expectation(description: expectationMessage)
        //act
        sut.execute(request: mockRequest) { (result: Result<MockSuccessObject, Error> ) in
            switch result {
            case .failure:
                break
            case .success(let value):
                XCTAssertNotNil(value)
                exp.fulfill()
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
    }

    func test_apiClientExecute_returns_jsonConversionError_when_dataTaskReturnsInvalidData() {
        //arrange
        let mockUrlSession = MockURLSession()
        mockUrlSession.return200 = true
        mockUrlSession.returnInCorrectData = true
        let sut = APIClientImplementation(urlSession: mockUrlSession)
        let mockRequest = CurrentDayApiRequest(location: ForecastRequestLocation(latitude: "0", longitude: "0"))
        let exp = expectation(description: expectationMessage)
        //act
        sut.execute(request: mockRequest) { (result: Result<MockSuccessObject, Error> ) in
            switch result {
            case .failure(let err):
                //assert
                XCTAssertEqual(err.localizedDescription, APIError.jsonConversionFailure.localizedDescription)
                exp.fulfill()
            case .success:
                break
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
    }

    func test_apiClientExecute_returns_invalidError_when_dataTaskReturnsnilData() {
        //arrange
        let mockUrlSession = MockURLSession()
        mockUrlSession.return200 = true
        mockUrlSession.returnNilData = true
        let sut = APIClientImplementation(urlSession: mockUrlSession)
        let mockRequest = CurrentDayApiRequest(location: ForecastRequestLocation(latitude: "0", longitude: "0"))
        let exp = expectation(description: expectationMessage)
        //act
        sut.execute(request: mockRequest) { (result: Result<MockSuccessObject, Error> ) in
            switch result {
            case .failure(let err):
                //assert
                XCTAssertEqual(err.localizedDescription, APIError.invalidData.localizedDescription)
                exp.fulfill()
            case .success:
                break
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
    }

    func test_apiClientExecute_returns_unSuccessfulResponse_when_dataTaskReturnsUnsuccessfulResponse() {
        //arrange
        let mockUrlSession = MockURLSession()
        let sut = APIClientImplementation(urlSession: mockUrlSession)
        let mockRequest = CurrentDayApiRequest(location: ForecastRequestLocation(latitude: "0", longitude: "0"))
        let exp = expectation(description: expectationMessage)
        //act
        sut.execute(request: mockRequest) { (result: Result<MockSuccessObject, Error> ) in
            switch result {
            case .failure(let err):
                //assert
                XCTAssertEqual(err.localizedDescription, APIError.responseUnsuccessful.localizedDescription)
                exp.fulfill()
            case .success:
                break
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
}

class MockURLSession: URLSessionProtocol {
    var returnError = false
    var return200 = false
    var returnInCorrectData = false
    var returnNilData = false
    let testUrl = "https://google.com"

     func dataTask(with request: URLRequest,
                   completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let successResponse = HTTPURLResponse(url: URL(string: testUrl)!,
                                              statusCode: 200, httpVersion: nil, headerFields: nil)
        if returnError {
            completionHandler(nil, nil, APIError.requestFailed)
        } else if returnNilData {
            completionHandler(nil, successResponse, nil)
        } else {
            var response: URLResponse!
            if return200 &&  !returnInCorrectData {
                let data = Data("{\"test\": \"data\"}".utf8)
                completionHandler(data, successResponse, nil)
            } else if returnInCorrectData {
                let data = Data("{\"wrong\": \"data\"}".utf8)
                completionHandler(data, successResponse, nil)
            } else {
                let data = Data("error".utf8)
                  response = HTTPURLResponse(url: URL(string: testUrl)!,
                                             statusCode: 400, httpVersion: nil, headerFields: nil)
                completionHandler(data, response, nil)
            }
        }
        return URLSessionDataTask()
    }
}

class MockSuccessObject: Codable {
    var test: String
}
