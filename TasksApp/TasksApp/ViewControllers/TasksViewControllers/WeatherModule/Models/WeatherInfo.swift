//
//  WeatherInfo.swift
//  TasksApp
//
//  Created by user on 10.04.2024.
//

import Foundation

struct WeatherInfo {
    let countryName: String
    let cityName: String
    let currentTemp: Int
    let averageDayTemp: Int?
    let averageNightTemp: Int?
    
    var currentTempDescription: String {
        switch currentTemp {
        case 1, 21, 31, 41:
            return "Температура сейчас \(currentTemp) градус"
        case 2, 3, 4, 22, 23, 24, 32, 33, 34, 42, 43, 44:
            return "Температура сейчас \(currentTemp) градуса"
        default:
            return "Температура сейчас \(currentTemp) градусов"
        }
    }
    
    var averageDayTempDescription: String {
        if let averageDayTemp = averageDayTemp {
            switch averageDayTemp {
            case 1, 21, 31, 41:
                return "Средняя температура днем \(averageDayTemp) градус"
            case 2, 3, 4, 22, 23, 24, 32, 33, 34, 42, 43, 44:
                return "Средняя температура днем \(averageDayTemp) градуса"
            default:
                return "Средняя температура днем \(averageDayTemp) градусов"
            }
        }
        return "Нет данных о средней температуре днем"
    }
    
    var averageNightTempDescription: String {
        if let averageNightTemp = averageNightTemp {
            switch averageNightTemp {
            case 1, 21, 31, 41:
                return "Средняя температура ночью \(averageNightTemp) градус"
            case 2, 3, 4, 22, 23, 24, 32, 33, 34, 42, 43, 44:
                return "Средняя температура ночью \(averageNightTemp) градуса"
            default:
                return "Средняя температура ночью \(averageNightTemp) градусов"
            }
        }
        return "Нет данных о средней температуре ночью"
    }
    
    init(weatherData: WeatherData) {
        self.countryName = weatherData.geoObject.country.name
        self.cityName = weatherData.geoObject.locality.name
        self.currentTemp = weatherData.fact.temp
        self.averageDayTemp = weatherData.forecasts.first?.parts.day.tempAvg
        self.averageNightTemp = weatherData.forecasts.first?.parts.night.tempAvg
    }
}
