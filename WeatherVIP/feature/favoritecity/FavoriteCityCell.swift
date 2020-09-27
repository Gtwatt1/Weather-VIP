//
//  FavoriteCityCell.swift
//  WeatherVIP
//
//  Created by Olorunshola Godwin on 28/09/2020.
//  Copyright © 2020 Olorunshola Godwin. All rights reserved.
//

import Foundation
import UIKit

class FavoriteCityCell: UITableViewCell {
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherTypeIcon: UIImageView!
    let weatherHelper = WeatherHelper()

    func configure(viewModel: FavoriteCity) {
        cityLabel.text = viewModel.cityName
        let imageName = weatherHelper.getWeatherType(viewModel.weatherDescription).rawValue
        weatherTypeIcon.image =  UIImage(named: imageName)
        currentTempLabel.text = weatherHelper.decorateWithTemperatureDegree(viewModel.temperature)
        dateLabel.text = "last update: " + weatherHelper.unixDateToStringDate(unix: viewModel.lastUpdateDate)
    }
}
