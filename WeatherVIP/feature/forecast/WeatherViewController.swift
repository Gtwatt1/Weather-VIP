//
//  WeatherViewController.swift
//  Weather-MVP
//
//  Created by Godwin Olorunshola on 16/12/2019.
//  Copyright © 2019 Godwin Olorunshola. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var moreCurrentDayTemperatureDetailsLabel: UIStackView!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.fetchWeatherForecast()
        view.backgroundColor = .red
    }

    var interactor: WeatherForecastLogic?

    func setup(interactor: WeatherForecastLogic) {
        self.interactor = interactor
    }
}

extension WeatherViewController: WeatherView {
    func didUpdateCurrentForecast(currentDayForecast: Forecast) {
    }

    func didUpdateFiveDaysForecast() {

    }

    func didUpdateWithError() {

    }

    func didChangeTheme() {
        
    }
}
