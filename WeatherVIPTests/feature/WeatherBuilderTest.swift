//
//  WeatherBuilderTest.swift
//  WeatherVIPTests
//
//  Created by Olorunshola Godwin on 27/09/2020.
//  Copyright © 2020 Olorunshola Godwin. All rights reserved.
//

import Foundation
import XCTest
@testable import WeatherVIP

class WeatherBuilderTest: XCTestCase {

    func test_build_configure_scene_parts() {
        //act
        let sut = WeatherBuilder().build()
        let navigationController =  sut as? UINavigationController
        let viewController = navigationController?.viewControllers.first as? WeatherViewController
        let interator = viewController?.interactor as? WeatherInteractor
        //assert
        XCTAssertNotNil(viewController?.interactor)
        XCTAssertNotNil(interator?.presenter)
    }
}
