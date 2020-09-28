//
//  FavoriteCityInteractor.swift
//  WeatherVIP
//
//  Created by Olorunshola Godwin on 27/09/2020.
//  Copyright © 2020 Olorunshola Godwin. All rights reserved.
//

import Foundation

protocol FavoriteCityLogic {
    func fetchFavoriteCities()
}

class FavoriteCityInteractor {
    let presenter: FavoriteCityPresentationLogic
    var worker = FavoriteCityWorker()

    init(presenter: FavoriteCityPresentationLogic ) {
        self.presenter = presenter
    }
}

extension FavoriteCityInteractor: FavoriteCityLogic {
    func fetchFavoriteCities() {
        if let cities = worker.fetchFavoritiesCities() {
            presenter.didFetchFavoriteCities(cities)
        } else {
            presenter.didFetchNoFavoritiesCities()
        }
    }
}
