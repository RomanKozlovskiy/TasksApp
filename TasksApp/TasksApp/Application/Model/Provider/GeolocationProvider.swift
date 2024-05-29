//
//  GeolocationProvider.swift
//  TasksApp
//
//  Created by user on 27.05.2024.
//

import Foundation

final class GeolocationProvider {
    private let coreDataService: CoreDataServiceProtocol
    
    init(coreDataService: CoreDataServiceProtocol) {
        self.coreDataService = coreDataService
    }
    
    func saveCoordinates(_ coordinates: Coordinates) {
        coreDataService.saveCoordinates { context in
             let coordinatesManagedObject = CoordinatesManagedObject(context: context)
            coordinatesManagedObject.longitude = coordinates.longitude
            coordinatesManagedObject.latitude = coordinates.latitude
            coordinatesManagedObject.timestamp = coordinates.timestamp
        }
    }
    
    func getLastCoordinates() -> Coordinates? {
        do {
            let coordinatesManagedObject = try coreDataService.fetchCoordinates()
            
            guard
                let longitude = coordinatesManagedObject.last?.longitude,
                let latitude = coordinatesManagedObject.last?.latitude,
                let timestamp = coordinatesManagedObject.last?.timestamp
            else {
                return nil
            }
            
            let lastCoordinates = Coordinates(longitude: longitude, latitude: latitude, timestamp: timestamp)
            
            return lastCoordinates
            
        } catch let error {
            print(error)
            return nil
        }
    }
}
