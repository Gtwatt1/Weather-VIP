//
//  WeatherCell.swift
//  WeatherVIP
//
//  Created by Olorunshola Godwin on 26/09/2020.
//  Copyright © 2020 Olorunshola Godwin. All rights reserved.
//

import Foundation

import UIKit

class WeatherCell: UITableViewCell {
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherTypeImage: UIImageView!
    @IBOutlet weak var currentTempLabel: UILabel!

    func configure(viewModel: ComingDaysForecastVM) {
        dayLabel.text = viewModel.day
        weatherTypeImage.image = UIImage(named: viewModel.weatherIcon)
        currentTempLabel.text = viewModel.temperature
    }
}
