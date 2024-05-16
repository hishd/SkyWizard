//
//  MockWeatherService.swift
//  SkyWizardTests
//
//  Created by Hishara Dilshan on 2024-05-16.
//

import Foundation
import Combine
import CoreLocation
@testable import SkyWizard

struct MockWeatherService: WeatherService {
    func getWeather(for location: CLLocation) -> AnyPublisher<WeatherResult, WeatherError> {
        return Future { promise in
            promise(.success(WeatherResult.sample))
        }.eraseToAnyPublisher()
    }
    
    public func getWeather(for location: CLLocation) async throws -> WeatherResult {
        return WeatherResult.sample
    }
}
