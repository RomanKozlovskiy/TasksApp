//
//  GeolocationViewController.swift
//  TasksApp
//
//  Created by user on 23.05.2024.
//

import UIKit
import CoreLocation
import SnapKit

final class GeolocationViewController: UIViewController {
    private var longitudeTitle: UILabel!
    private var latitudeTitle: UILabel!
    private var timestampTitle: UILabel!
    
    private let stackView = UIStackView()
    
    private let geolocationProvider: GeolocationProvider
    
    private let locationManager = CLLocationManager()
    private var lastLocation: CLLocation?
    
    private var timer: Timer?
    
    private var currentCoordinates: Coordinates?
    
    init(geolocationProvider: GeolocationProvider) {
        self.geolocationProvider = geolocationProvider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.7155137756, green: 1, blue: 0.9808211153, alpha: 1)
        
        configureStackView()
        configureLocationManager()
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appDidEnterBackgroundOrTerminate), name: UIApplication.didEnterBackgroundNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(appDidEnterBackgroundOrTerminate), name: UIApplication.willTerminateNotification, object: nil)
    
        timer = Timer.scheduledTimer(timeInterval: 300, target: self, selector: #selector(updateLocation), userInfo: nil, repeats: true)
    }
    
    private func createLabel(numberOfLines: Int = 0, fontSize: CGFloat = 22 ) -> UILabel {
        let label = UILabel()
        label.numberOfLines = numberOfLines
        label.font = UIFont.systemFont(ofSize: fontSize)
        return label
    }
    
    private func configureStackView() {
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        
        longitudeTitle = createLabel()
        latitudeTitle = createLabel()
        timestampTitle = createLabel()
        
        stackView.addArrangedSubview(longitudeTitle)
        stackView.addArrangedSubview(latitudeTitle)
        stackView.addArrangedSubview(timestampTitle)
        
        view.addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalToSuperview().inset(10)
            $0.height.equalTo(400)
        }
        
        stackView.layer.cornerRadius = 20
    }

    private func configureTitleDescription(from coordinates: Coordinates?) {
        guard let coordinates else { return }
        longitudeTitle.text = coordinates.longitudeDescription
        latitudeTitle.text = coordinates.latitudeDescription
        timestampTitle.text = coordinates.timestampDescription
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
    
    @objc private func updateLocation() {
        locationManager.startUpdatingLocation()
        let coordinates = locationManager.location?.coordinate
        
        guard
            let longitude = coordinates?.longitude,
            let latitude = coordinates?.latitude,
            let timestamp = locationManager.location?.timestamp
        else {
            return
        }
        
        let lastCoordinates = Coordinates(longitude: longitude, latitude: latitude, timestamp: timestamp)
        geolocationProvider.saveCoordinates(lastCoordinates)
    }
    
    @objc private func appDidEnterBackgroundOrTerminate() {
        createRegion(location: lastLocation)
    }
    
    private func createRegion(location: CLLocation?) {
        if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
            
            guard
                let longitude = location?.coordinate.longitude,
                let latitude = location?.coordinate.latitude
            else {
                return
            }
            
            let coordinate = CLLocationCoordinate2DMake(latitude, longitude)
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
        guard let location = locations.last else {
            if let coordinatesFromCoreData = geolocationProvider.getLastCoordinates() {
                configureTitleDescription(from: coordinatesFromCoreData)
            }
            return
        }
        
        currentCoordinates = Coordinates(longitude: location.coordinate.longitude, latitude: location.coordinate.latitude, timestamp: location.timestamp)
        configureTitleDescription(from: currentCoordinates)

        if UIApplication.shared.applicationState != .active  {
            self.lastLocation = locations.last
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
