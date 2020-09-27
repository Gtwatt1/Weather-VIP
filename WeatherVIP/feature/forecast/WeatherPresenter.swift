//
//  WeatherPresenter.swift
//  Weather-MVP
//
//  Created by Godwin Olorunshola on 16/12/2019.
//  Copyright © 2019 Godwin Olorunshola. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherCellView {
    func displayDay(day: String)
    func displayWeatherType(image: String)
    func displayTemperature(temp: String)
}

protocol WeatherPresentationLogic {
    func presentCurrentDayWeather(forecast: Forecast)
    func presentFiveDaysWeather(forecastList: ForecastList)
    func presentError(error: String)
}

class WeatherPresenter {
    var backgroundColor = "", weatherImage = "", error = ""
    weak private var view: WeatherDisplayLogic?
    var fiveDaysForecast: [Forecast]?

    func setView(view: WeatherDisplayLogic) {
        self.view = view
    }

    var weatherType = WeatherType.cloudy {
        didSet {
            setBackgroundView()
        }
    }

    func changeTheme() {
        if let theme = theme {
            if  theme == .forest {
                self.theme = .sea
            } else {
                self.theme = .forest
            }
        }
    }
    func configureCell(cell: WeatherCellView, row: Int) {
        let dayForecast = fiveDaysForecast?[row]
        let weatherImage = getWeatherType(dayForecast?.weather[0].main.lowercased() ?? "")
        let cellDay = getDayOfTheWeek(intDate: dayForecast?.unixDate ?? 0)
        cell.displayWeatherType(image: weatherImage.rawValue)
        cell.displayDay(day: cellDay)
        cell.displayTemperature(temp: "\(Int(dayForecast?.main.temp.rounded() ?? 0.0) )º")
    }

    func setBackgroundView() {
        switch weatherType {
        case .cloudy:
            weatherImage = theme == Theme.forest ? "forest_cloudy" : "sea_cloudy"
            backgroundColor = "54717A"
        case .rainy:
            weatherImage = theme == Theme.forest ? "forest_rainy" : "sea_rainy"
            backgroundColor = "57575D"
        case .sunny:
            weatherImage = theme == Theme.forest ? "forest_sunny" : "sea_sunny"
            backgroundColor = "47AB2F"
        }
    }

    var theme: Theme? {
        didSet {
            if let _ = theme {
                setBackgroundView()
            }
            //            view?.didChangeTheme()
        }
    }

    private func getWeatherType(_ weatherMain: String) -> WeatherType {
        switch weatherMain.lowercased() {
        case "rain", "thunderstorm", "drizzle", "snow", "mist":
            return WeatherType.rainy
        case let str where str.contains("cloud"):
            return WeatherType.cloudy
        default:
            return WeatherType.sunny
        }
    }

    private func getWeatherBackground(_ weatherMain: String) -> ViewBackground {
        let weatherType = getWeatherType(weatherMain)
        switch weatherType {
        case .cloudy:
            let backgroundImage = theme == Theme.forest ? "forest_cloudy" : "sea_cloudy"
            return ViewBackground(weatherImage: backgroundImage, backgroundColor: ColorName.cloudyBackground)
        case .rainy:
            let backgroundImage = theme == Theme.forest ? "forest_rainy" : "sea_rainy"
            return ViewBackground(weatherImage: backgroundImage, backgroundColor: ColorName.rainyBackground)
        case .sunny:
            let backgroundImage = theme == Theme.forest ? "forest_sunny" : "sea_sunny"
            return ViewBackground(weatherImage: backgroundImage, backgroundColor: ColorName.sunnyBackground)
        }
    }

    func getDayOfTheWeek(intDate: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(intDate))
        return date.dayOfWeek()
    }

    private func currentDayViewModelMapping(forecast: Forecast) -> CurrentDayForecastVM {
        let viewModel = CurrentDayForecastVM(cityName: forecast.name ?? "",
                                             weatherDescription: forecast.weather[0].weatherDescription.capitalized,
                                             temperature: decorateWithTemperatureDegree(forecast.main.temp),
                                             minimalTemperature: decorateWithTemperatureDegree(forecast.main.tempMin),
                                             maximalTemperature: decorateWithTemperatureDegree(forecast.main.tempMax))
        return viewModel
    }

    private func comingDaysViewModelMapping(forecasts: [Forecast]) -> [ComingDaysForecastVM] {
        var comingDaysViewModel = [ComingDaysForecastVM]()
        let filteredForecaset = filterEarlyMorningForecast(forecasts)
        filteredForecaset.forEach {
            let viewModel = ComingDaysForecastVM(day: getDayOfTheWeek(intDate: $0.unixDate),
                                                 temperature: decorateWithTemperatureDegree($0.main.temp),
                                                 weatherIcon: getWeatherType($0.weather[0].main).rawValue)
            comingDaysViewModel.append(viewModel)
        }
        return comingDaysViewModel
    }

    private func decorateWithTemperatureDegree(_ value: Double) -> String {
        return "\(value)º"
    }

    private func filterEarlyMorningForecast(_ forecastList: [Forecast]) -> [Forecast] {
        let earlyMorningForecast = forecastList.filter({
            if let dateTime = $0.dateString {
                return dateTime.contains("06:00:00")
            }
            return false
        })
        return earlyMorningForecast
    }
}

extension WeatherPresenter: WeatherPresentationLogic {
    func presentCurrentDayWeather(forecast: Forecast) {
        let viewModel = currentDayViewModelMapping(forecast: forecast)
        let weatherBackground = getWeatherBackground(forecast.weather[0].main)
        view?.displayCurrentDayWeather(viewModel: viewModel)
        view?.displayViewBackground(weatherBackground)
    }

    func presentFiveDaysWeather(forecastList: ForecastList) {
        let viewModels = comingDaysViewModelMapping(forecasts: forecastList.list)
        view?.displayComingDaysWeather(cellRepresentable: viewModels)
    }

    func presentError(error: String) {
        view?.displayError(error)
    }

}
