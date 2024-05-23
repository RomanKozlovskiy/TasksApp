//
//  GeolocationViewController.swift
//  TasksApp
//
//  Created by user on 23.05.2024.
//

import UIKit
import CoreLocation

final class GeolocationViewController: UIViewController {
    
    let locationManager: CLLocationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .cyan
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.showsBackgroundLocationIndicator = true
        
        requestLocationUpdate()
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.distanceFilter = 50
        DispatchQueue.main.asyncAfter(deadline: .now() + 25) {
            self.stopLocationUpdate()
        }
    }
    
    private func requestLocationUpdate() {
        locationManager.startUpdatingLocation()
    }
    
    private func stopLocationUpdate() {
        locationManager.stopUpdatingLocation()
    }
}

extension GeolocationViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        print("Latitude: \(location.coordinate.latitude), Longitude: \(location.coordinate.longitude), Date - \(location.timestamp)")
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        
        if let clErr = error as? CLError {
            switch clErr.code {
            case .locationUnknown, .denied, .network:
                print("Location request failed with error: \(clErr.localizedDescription)") //TODO: -  added alert!
            case .headingFailure:
                print("Heading request failed with error: \(clErr.localizedDescription)")
            case .rangingUnavailable, .rangingFailure:
                print("Ranging request failed with error: \(clErr.localizedDescription)")
            case .regionMonitoringDenied, .regionMonitoringFailure, .regionMonitoringSetupDelayed, .regionMonitoringResponseDelayed:
                print("Region monitoring request failed with error: \(clErr.localizedDescription)")
            default:
                print("Unknown location manager error: \(clErr.localizedDescription)")
            }
        } else {
            print("Unknown error occurred while handling location manager error: \(error.localizedDescription)")
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            print("When user did not yet determined")
        case .restricted:
            print("Restricted by parental control")
        case .denied:
            print("When user select option Don't Allow")
        case .authorizedWhenInUse:
            locationManager.requestAlwaysAuthorization()
            print("When user select option Allow While Using App or Allow Once")
        case .authorizedAlways:
            print("When user select option Allow")
        default:
            print("default")
        }
    }
}
