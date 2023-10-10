//
//  ViewController.swift
//  SkyWizard
//
//  Created by Hishara Dilshan on 2023-10-10.
//

import UIKit
import OSLog

class WeatherViewController: UIViewController {
    
    let primaryView = WeatherView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(primaryView)
        primaryView.fillSuperViewSafeArea()
        
        getLocation()
    }
    
    private func getLocation() {
        LocationService.shared.getCurrentLocation { location in
            Logger.viewCycle.info("Location Lat: \(location.coordinate.latitude) Location Lon: \(location.coordinate.longitude)")
        }
    }

}

