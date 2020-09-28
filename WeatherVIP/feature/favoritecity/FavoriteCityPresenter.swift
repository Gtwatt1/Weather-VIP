//
//  FavoriteCityPresenter.swift
//  WeatherVIP
//
//  Created by Olorunshola Godwin on 27/09/2020.
//  Copyright © 2020 Olorunshola Godwin. All rights reserved.
//

import Foundation

protocol FavoriteCityPresentationLogic {
    func didFetchFavoriteCities(_ cities: [FavoriteCity])
    func didFetchNoFavoritiesCities()
}

class FavoriteCityPresenter {
    weak var view: FavoriteCityDisplayLogic?

    func setView(view: FavoriteCityDisplayLogic) {
        self.view = view
    }
}

extension FavoriteCityPresenter: FavoriteCityPresentationLogic {
    func didFetchNoFavoritiesCities() {
        view?.displayEmptyList()
    }

    func didFetchFavoriteCities(_ cities: [FavoriteCity]) {
        view?.displayFavoriteCities(cities: cities)
    }
}
