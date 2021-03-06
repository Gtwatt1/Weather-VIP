//
//  WeatherPresenter.swift
//  Weather-MVP
//
//  Created by Godwin Olorunshola on 16/12/2019.
//  Copyright © 2019 Godwin Olorunshola. All rights reserved.
//

import Foundation

protocol WeatherPresentationLogic {
    func presentCurrentDayWeather(forecast: Forecast)
    func presentFiveDaysWeather(forecastList: ForecastList)
    func presentError(error: String)
    var userInterfaceStyle: UserInterfaceStyle! {get set}
}

class WeatherPresenter {
    weak var view: WeatherDisplayLogic?
    var userInterfaceStyle: UserInterfaceStyle!
    let weatherHelper = WeatherHelper()

    func setView(view: WeatherDisplayLogic) {
        self.view = view
    }

    func getWeatherBackground(_ weatherName: String) -> ViewBackground {
        let weatherType = weatherHelper.getWeatherType(weatherName)
        switch weatherType {
        case .cloudy:
            return userInterfaceStyle.fetchCloudyBackground()
        case .rainy:
            return userInterfaceStyle.fetchRainyBackground()
        case .sunny:
            return userInterfaceStyle.fetchSunnyBackground()
        }
    }

    func getDayOfTheWeek(intDate: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(intDate))
        return date.dayOfWeek()
    }

    func currentDayViewModelMapping(forecast: Forecast) -> CurrentDayForecastVM {
        let viewModel = CurrentDayForecastVM(cityName: forecast.name ?? "",
                                             weatherDescription: forecast.weather[0].weatherDescription.capitalized,
                                             temperature: decorateWithTemperatureDegree(forecast.main.temp),
                                             minimalTemperature: decorateWithTemperatureDegree(forecast.main.tempMin),
                                             maximalTemperature: decorateWithTemperatureDegree(forecast.main.tempMax))
        return viewModel
    }

    func comingDaysViewModelMapping(forecasts: [Forecast]) -> [ComingDaysForecastVM] {
        var comingDaysViewModel = [ComingDaysForecastVM]()
        let filteredForecaset = filterEarlyMorningForecast(forecasts)
        filteredForecaset.forEach {
            let viewModel = ComingDaysForecastVM(day: getDayOfTheWeek(intDate: $0.unixDate),
                                                 temperature: decorateWithTemperatureDegree($0.main.temp),
                                                 weatherIcon: weatherHelper.getWeatherType($0.weather[0].main).rawValue)
            comingDaysViewModel.append(viewModel)
        }
        return comingDaysViewModel
    }

    func decorateWithTemperatureDegree(_ value: Double) -> String {
        return "\(value)º"
    }

    func filterEarlyMorningForecast(_ forecastList: [Forecast]) -> [Forecast] {
        let earlyMorningForecast = forecastList.filter({
            if let dateTime = $0.dateString {
                return dateTime.contains(WeatherConstants.preferredWeatherType)
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
