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
    
    override init() {
        super.init()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
    }

    public func getCurrentLocation(callback: @escaping (CLLocation) -> Void) {
        locationManager.startUpdatingLocation()
        self.locationFetchedCallback = callback
        
        if let location = locationManager.location {
            self.fetchedLocation = location
        }
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
