//
//  LocationServiceTest.swift
//  WeatherVIPTests
//
//  Created by Olorunshola Godwin on 27/09/2020.
//  Copyright © 2020 Olorunshola Godwin. All rights reserved.
//

import Foundation
import XCTest
import CoreLocation
@testable import WeatherVIP

class LocationServiceTest: XCTestCase {
    var sut: LocationService!
    let locationManager = MockLocationManager()

    override func setUp() {
        sut = LocationService()
        sut.locationManager = locationManager
    }

    func test_startLocationRequest_calls_LocationManagerRequestLocation() {
        //act
        sut.startLocationRequest()
        //assert
        XCTAssertTrue(locationManager.requestLocationCalled)
    }

    func test_locationManagerDidFailWithError_calls_locationServiceDelegate_locationdidFail() {
        //arrange
        let locationServiceDelegate =  MockLocationServiceDelegate()
        sut.delegate = locationServiceDelegate
        //act
        sut.locationManager(locationManager, didFailWithError: APIError.requestFailed)
        //assert
        XCTAssertTrue(locationServiceDelegate.locationdidFailCalled)
    }
}

class MockLocationManager: CLLocationManager {
    var requestLocationCalled = false
    override func requestLocation() {
        requestLocationCalled = true
    }
}

class MockLocationServiceDelegate: LocationServiceDelegate {
    var didGetLocationCalled = false
    var locationdidFailCalled = false
    func didGetLocation(_ lat: String, lng: String) {
        didGetLocationCalled = true
    }

    func locationdidFail(_ reason: String) {
        locationdidFailCalled = true
    }
}
