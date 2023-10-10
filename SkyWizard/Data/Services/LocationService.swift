//
//  LocationService.swift
//  SkyWizard
//
//  Created by Hishara Dilshan on 2023-10-10.
//

import Foundation
import CoreLocation


final class LocationService: NSObject {
    public static let shared = LocationService()
    
    private override init(){
        super.init()
    }
}
