//
//  WKService.swift
//  SkyWizard
//
//  Created by Hishara Dilshan on 2023-10-10.
//

import Foundation
import CoreLocation
import OSLog
import Combine

final class OpenMetroWeatherService: WeatherService {
    func getWeather(for location: CLLocation) -> Future<WeatherResult, WeatherError> {
        return Future { promise in
            promise(.success(WeatherResult()))
        }
    }
    
    public func getWeather(for location: CLLocation) async throws -> WeatherResult {
        return WeatherResult()
    }
}
