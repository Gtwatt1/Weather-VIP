//
//  FavoriteCityWorker.swift
//  WeatherVIP
//
//  Created by Olorunshola Godwin on 27/09/2020.
//  Copyright © 2020 Olorunshola Godwin. All rights reserved.
//

import Foundation

class FavoriteCityWorker {

    func fetchFavoritiesCities() -> [FavoriteCity]? {
        let favorietCities: [FavoriteCity]? = UserDefaultHelper().get(key: .favoriteCityList)
        return favorietCities
    }
}
