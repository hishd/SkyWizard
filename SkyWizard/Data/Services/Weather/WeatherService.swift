//
//  WeatherService.swift
//  SkyWizard
//
//  Created by Hishara Dilshan on 2024-05-16.
//

import Foundation
import CoreLocation
import Combine

protocol WeatherService {
    func getWeather(for location: CLLocation) async throws -> WeatherResult
    func getWeather(for location: CLLocation) -> Future<WeatherResult, WeatherError>
}
