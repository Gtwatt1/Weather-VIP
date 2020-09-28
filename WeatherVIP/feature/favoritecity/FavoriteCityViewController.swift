//
//  FavoriteCityViewController.swift
//  WeatherVIP
//
//  Created by Olorunshola Godwin on 27/09/2020.
//  Copyright © 2020 Olorunshola Godwin. All rights reserved.
//

import UIKit

protocol FavoriteCityDisplayLogic: class {
    func displayFavoriteCities(cities: [FavoriteCity] )
    func displayEmptyList()
}

class FavoriteCityViewController: UIViewController {
    @IBOutlet weak var tableview: UITableView!
    var interactor: FavoriteCityLogic?
    var tableManager = FavoriteCityTableManager()
    let showMapString = "Show Map"

    func setup(interactor: FavoriteCityLogic) {
        self.interactor = interactor
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.fetchFavoriteCities()
        title = "Favorites"
        tableview.dataSource = tableManager
        tableview.delegate = tableManager
        navigationItem.rightBarButtonItem = UIBarButtonItem(
                                                    title: showMapString, style: .plain,
                                                    target: self, action: #selector(showMapTapped))
    }

    @objc func showMapTapped() {
        let mapViewController = MapViewController()
        mapViewController.favoriteCities = tableManager.favoriteCities
        navigationController?.pushViewController(mapViewController, animated: true)
    }
}

extension FavoriteCityViewController: FavoriteCityDisplayLogic {
    func displayFavoriteCities(cities: [FavoriteCity]) {
        tableManager.favoriteCities = cities
        tableview.reloadData()
    }

    func displayEmptyList() {
        showAlert(withMessage: "No Favorites Found")
    }
}
