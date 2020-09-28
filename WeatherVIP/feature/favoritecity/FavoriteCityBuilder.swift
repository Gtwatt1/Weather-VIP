//
//  FavoriteCityBuilder.swift
//  WeatherVIP
//
//  Created by Olorunshola Godwin on 27/09/2020.
//  Copyright © 2020 Olorunshola Godwin. All rights reserved.
//

import Foundation
import UIKit

class FavoriteCityBuilder: SceneBuilder {
    func build() -> UIViewController {
        let presenter = FavoriteCityPresenter()
        let interactor = FavoriteCityInteractor(presenter: presenter)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let controller = storyboard.instantiateViewController(withIdentifier:
            "FavoriteCityViewController") as? FavoriteCityViewController {
            controller.setup(interactor: interactor)
            presenter.setView(view: controller)
            return controller
        }
        return UIViewController()
    }
}
