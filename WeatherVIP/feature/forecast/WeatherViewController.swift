//
//  WeatherViewController.swift
//  Weather-MVP
//
//  Created by Godwin Olorunshola on 16/12/2019.
//  Copyright © 2019 Godwin Olorunshola. All rights reserved.
//

import UIKit

protocol WeatherDisplayLogic: class {
    func displayCurrentDayWeather(viewModel: CurrentDayForecastVM)
    func displayViewBackground(_ background: ViewBackground)
    func displayComingDaysWeather(cellRepresentable: [ComingDaysForecastVM])
    func displayError(_ error: String)
}

class WeatherViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var moreCurrentDayTemperatureDetailsLabel: UIStackView!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var tableManager = WeatherTableManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = tableManager
        tableView.delegate = tableManager
        interactor?.fetchWeatherForecast()
    }

    var interactor: WeatherForecastLogic?
    var userInterfaceStyle: UserInterfaceStyle?

    func setup(interactor: WeatherForecastLogic) {
        if #available(iOS 12.0, *) {
            if self.traitCollection.userInterfaceStyle == .dark {
                userInterfaceStyle = DarkModeInterfaceStyle()
            } else {
                userInterfaceStyle = LightModeInterfaceStyle()
            }
        } else {
           userInterfaceStyle = LightModeInterfaceStyle()
        }
        self.interactor = interactor
        self.interactor?.userInterfaceStyle = userInterfaceStyle
    }

    func updateCurrentDayWeatherLabels(_ viewModel: CurrentDayForecastVM) {
        temperatureLabel.text = viewModel.temperature
        currentTemperatureLabel.text = viewModel.temperature
        title = viewModel.cityName
        minTemperatureLabel.text = viewModel.minimalTemperature
        maxTemperatureLabel.text = viewModel.maximalTemperature
        weatherDescriptionLabel.text = viewModel.weatherDescription
        [temperatureLabel, weatherDescriptionLabel].forEach({$0.fadeIn()})
    }

    func updateViewBackground(_ background: ViewBackground) {
        weatherImage.image = UIImage(named: background.weatherImage)
        tableView.backgroundColor = UIColor(named: background.backgroundColor)
        moreCurrentDayTemperatureDetailsLabel.addBackground(color: UIColor(named: background.backgroundColor))
    }
}

extension WeatherViewController: WeatherDisplayLogic {
    func displayViewBackground(_ background: ViewBackground) {
        DispatchQueue.main.async {
            self.updateViewBackground(background)
        }
    }
    func displayCurrentDayWeather(viewModel: CurrentDayForecastVM) {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.updateCurrentDayWeatherLabels(viewModel)
        }
    }

    func displayComingDaysWeather(cellRepresentable: [ComingDaysForecastVM]) {
        tableManager.weatherCellviewModels = cellRepresentable
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func displayError(_ error: String) {
        showAlert(withMessage: error)
    }
}
