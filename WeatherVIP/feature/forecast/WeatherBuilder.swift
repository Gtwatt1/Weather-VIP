//
//  WeatherBuilder.swift
//  WeatherVIP
//
//  Created by Olorunshola Godwin on 26/09/2020.
//  Copyright © 2020 Olorunshola Godwin. All rights reserved.
//

import Foundation
import UIKit

class WeatherBuilder: SceneBuilder {
    func build() -> UIViewController {
        let presenter = WeatherPresenter()
        let interactor = WeatherInteractor(presenter: presenter)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let controller = storyboard.instantiateViewController(withIdentifier:
            "WeatherViewController") as? WeatherViewController {
            controller.setup(interactor: interactor)
            presenter.setView(view: controller)
            let navigationController = UINavigationController(rootViewController: controller)
            return navigationController
        }
        return UIViewController()
    }
}
