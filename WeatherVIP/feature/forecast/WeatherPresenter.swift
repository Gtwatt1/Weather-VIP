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
    func displayDay(day : String)
    func displayWeatherType(image : String)
    func displayTemperature(temp : String)
}

protocol WeatherView : class {
    func didUpdateCurrentForecast(currentDayForecast : Forecast)
    func didUpdateFiveDaysForecast()
    func didUpdateWithError()
    func didChangeTheme()
}


class WeatherPresenter {
    var backgroundColor = "", weatherImage = "", error = ""
    weak fileprivate var view : WeatherView?
    var fiveDaysForecast : [Forecast]?

    
    
    init(view : WeatherView) {
        self.view = view
    }
    
    var weatherType = WeatherType.cloudy{
        didSet{
            setBackgroundView()
        }
    }
    
    func changeTheme(){
        if let theme = theme{
            if  theme == .forest{
                self.theme = .sea
            }else{
                self.theme = .forest
            }
        }
    }
    
    
    func configureCell(cell : WeatherCellView, row: Int){
        let dayForecast = fiveDaysForecast?[row]
        let weatherImage = getWeatherType(dayForecast?.weather?[0].main?.lowercased())
        let cellDay = getDayOfTheWeek(intDate: dayForecast?.dt ?? 0)
        cell.displayWeatherType(image: weatherImage.rawValue)
        cell.displayDay(day: cellDay)
        cell.displayTemperature(temp: "\(Int(dayForecast?.main?.temp?.rounded() ?? 0.0) )º")
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
    
    var theme : Theme?{
        didSet{
            if let theme = theme{
                setBackgroundView()
            }
            view?.didChangeTheme()
        }
    }
    
    fileprivate func getWeatherType(_ weatherMain: String?) -> WeatherType{
        switch weatherMain {
        case "rain", "thunderstorm", "drizzle", "snow", "mist":
            return WeatherType.rainy
        case let str where str?.contains("cloud") ?? false:
            return WeatherType.cloudy
        default:
            return WeatherType.sunny
        }
    }
    
    func getDayOfTheWeek(intDate: Int) -> String{
        let date = Date(timeIntervalSince1970: TimeInterval(intDate))
        return date.description // dayOfWeek()
    }
    
    
}
