//
//  GeolocationViewController.swift
//  TasksApp
//
//  Created by user on 23.05.2024.
//

import UIKit
import CoreLocation

final class GeolocationViewController: UIViewController {
    private let locationManager = CLLocationManager()
    private var lastLocation: CLLocation?
    private var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        
        configureLocationManager()
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appDidEnterBackgroundOrTerminate), name: UIApplication.didEnterBackgroundNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(appDidEnterBackgroundOrTerminate), name: UIApplication.willTerminateNotification, object: nil)
        timer = Timer.scheduledTimer(timeInterval: 300, target: self, selector: #selector(updateLocation), userInfo: nil, repeats: true)
    }
    
    private func configureLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.showsBackgroundLocationIndicator = true
        
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.distanceFilter = 50
    }
    
    @objc func updateLocation() {
        locationManager.startUpdatingLocation()
        // set to Core Data
    }
    
    @objc private func appDidEnterBackgroundOrTerminate() {
        createRegion(location: lastLocation)
    }
    
    private func createRegion(location: CLLocation?) {
        if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
            let coordinate = CLLocationCoordinate2DMake((location?.coordinate.latitude)!, (location?.coordinate.longitude)!)
            let regionRadius = 50.0
            
            let region = CLCircularRegion(center: CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude),
                                          radius: regionRadius,
                                          identifier: String(describing: GeolocationViewController.self))
            
            region.notifyOnExit = true
            region.notifyOnEntry = true
            
            locationManager.stopUpdatingLocation()
            locationManager.startMonitoring(for: region)
        } else {
            print("System can't track regions")
        }
    }
}

extension GeolocationViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        print("Latitude: \(location.coordinate.latitude), Longitude: \(location.coordinate.longitude), Date - \(location.timestamp)")
        
        if UIApplication.shared.applicationState != .active  {
            
            let location = locations.last
            self.lastLocation = location
            self.createRegion(location: lastLocation)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        if let clError = error as? CLError {
            switch clError.code {
            case .locationUnknown, .denied, .network:
                print("Location request failed with error: \(clError.localizedDescription)")
            case .headingFailure:
                print("Heading request failed with error: \(clError.localizedDescription)")
            case .rangingUnavailable, .rangingFailure:
                print("Ranging request failed with error: \(clError.localizedDescription)")
            case .regionMonitoringDenied, .regionMonitoringFailure, .regionMonitoringSetupDelayed, .regionMonitoringResponseDelayed:
                print("Region monitoring request failed with error: \(clError.localizedDescription)")
            default:
                print("Unknown location manager error: \(clError.localizedDescription)")
            }
        } else {
            print("Unknown error occurred while handling location manager error: \(error.localizedDescription)")
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:
            locationManager.requestAlwaysAuthorization()
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        locationManager.stopMonitoring(for: region)
        locationManager.startUpdatingLocation()
    }
}
