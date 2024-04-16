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
        return "Температура сейчас \(currentTemp) \(getPluralForm(currentTemp, words: units))"
    }
    
    var averageDayTempDescription: String {
        if let averageDayTemp = averageDayTemp {
            return "Средняя температура днем \(averageDayTemp) \(getPluralForm(averageDayTemp, words: units))"
        }
        return "Нет данных о средней температуре днем"
    }
    
    var averageNightTempDescription: String {
        if let averageNightTemp = averageNightTemp {
            return "Средняя температура ночью \(averageNightTemp) \(getPluralForm(averageNightTemp, words: units))"
        }
        return "Нет данных о средней температуре ночью"
    }
    
    private let units = ["градус", "градуса", "градусов"]
    
    private func getPluralForm(_ number: Int, words: [String]) -> String {
        let absNumber = abs(number)
        let index = (absNumber % 100 > 4 && absNumber % 100 <= 20) ? 2 : absNumber % 10 == 1 ? 0 : (absNumber % 10 > 1 && absNumber % 10 < 5 ? 1 : 2)
        return words[index]
    }
    
    init(weatherData: WeatherData) {
        self.countryName = weatherData.geoObject.country.name
        self.cityName = weatherData.geoObject.locality.name
        self.currentTemp = weatherData.fact.temp
        self.averageDayTemp = weatherData.forecasts.first?.parts.day.tempAvg
        self.averageNightTemp = weatherData.forecasts.first?.parts.night.tempAvg
    }
}
