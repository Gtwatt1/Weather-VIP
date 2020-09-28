//
//  FavoriteCityTableManager.swift
//  WeatherVIP
//
//  Created by Olorunshola Godwin on 28/09/2020.
//  Copyright © 2020 Olorunshola Godwin. All rights reserved.
//

import Foundation

import UIKit

class FavoriteCityTableManager: NSObject {
    var favoriteCities: [FavoriteCity] = []
}

extension FavoriteCityTableManager: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteCities.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCityCell",
                                                    for: indexPath) as? FavoriteCityCell {
            cell.configure(viewModel: favoriteCities[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}

extension FavoriteCityTableManager: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(translationX: tableView.bounds.width, y: 0)
        UIView.animate(
            withDuration: 0.5,
            delay: 0.5 * Double(indexPath.row),
            options: [.curveEaseInOut],
            animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
        })
    }
}
