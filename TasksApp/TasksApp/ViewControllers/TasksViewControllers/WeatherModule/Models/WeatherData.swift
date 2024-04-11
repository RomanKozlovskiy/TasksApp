//
//  WeatherData.swift
//  TasksApp
//
//  Created by user on 10.04.2024.
//

import Foundation

struct WeatherData: Decodable {
    let geoObject: GeoObject
    let fact: Fact
    let forecasts: [Forecast]
    
    enum CodingKeys: String, CodingKey {
        case geoObject = "geo_object"
        case fact
        case forecasts
    }
}

struct GeoObject: Decodable {
    let country: Locality
    let locality: Locality
}

struct Locality: Decodable {
    let name: String
}

struct Fact: Decodable {
    let temp: Int
}

struct Forecast: Decodable {
    let parts: Parts
}

struct Parts: Decodable {
    let day: Day
    let night: Day
}

struct Day: Decodable {
    let tempAvg: Int?
    
    enum CodingKeys: String, CodingKey {
        case tempAvg = "temp_avg"
    }
}
