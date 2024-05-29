//
//  Coordinates.swift
//  TasksApp
//
//  Created by user on 27.05.2024.
//

import Foundation

struct Coordinates {
    let longitude: Double
    let latitude: Double
    let timestamp: Date
    
    var longitudeDescription: String {
        "Current longitude: \(longitude)"
    }
    
    var latitudeDescription: String {
        "Current latitude: \(latitude)"
    }
    
    var timestampDescription: String {
        "Last timestamp: \(convertTimestamp())"
    }
    
    func convertTimestamp() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss, dd.MM.yyyy"
        return dateFormatter.string(from: timestamp)
    }
}
