//
//  LocationService.swift
//  SkyWizard
//
//  Created by Hishara Dilshan on 2023-10-10.
//

import Foundation
import CoreLocation


final class LocationService: NSObject {
    private let locationManager = CLLocationManager()
    private var locationFetchedCallback: ((CLLocation) -> Void)?
    
    private var fetchedLocation: CLLocation? {
        didSet {
            guard let fetchedLocation else {
                return
            }
            
            locationFetchedCallback?(fetchedLocation)
        }
    }

    public func getCurrentLocation(callback: @escaping (CLLocation) -> Void) {
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        self.locationFetchedCallback = callback
    }
}

extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        self.fetchedLocation = location
        locationManager.stopUpdatingLocation()
    }
}
