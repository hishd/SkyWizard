//
//  WKService.swift
//  SkyWizard
//
//  Created by Hishara Dilshan on 2023-10-10.
//

import Foundation
import CoreLocation
import OSLog

final class WeatherService {
    public func getWeather(for location: CLLocation) async throws -> WeatherResult {
        return WeatherResult()
    }
}
