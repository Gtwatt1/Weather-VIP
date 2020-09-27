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

    func setup(interactor: FavoriteCityLogic) {
        self.interactor = interactor
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.fetchFavoriteCities()
        title = "Favorites"
        tableview.dataSource = tableManager
        tableview.delegate = tableManager
    }
}

extension FavoriteCityViewController: FavoriteCityDisplayLogic {
    func displayFavoriteCities(cities: [FavoriteCity]) {
        tableManager.cellviewModels = cities
        tableview.reloadData()
    }

    func displayEmptyList() {
        showAlert(withMessage: "No Favorites Found")
    }
}
