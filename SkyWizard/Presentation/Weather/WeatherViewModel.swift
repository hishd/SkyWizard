//
//  WeatherViewModel.swift
//  SkyWizard
//
//  Created by Hishara Dilshan on 2023-10-18.
//

import Foundation
import OSLog


class WeatherViewModel {
    
    let injector = DependencyInjector.shared.container
    typealias WeatherResult = WeatherKitService.WeatherResult
    
    @Published private(set) var weatherType: WeatherType?
    
    init() {
        weatherType = .day_sunny
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            self?.weatherType = .night_rainy
        }
    }
    
    private func getWeatherForCurrentLocation() async throws -> WeatherResult {
        return try await withCheckedThrowingContinuation { [weak self] continiation in
            
            guard let locationService = self?.injector.resolve(LocationService.self) else {
                continiation.resume(throwing: ApplicationError.notFound("LocationService dependancy in injector"))
                return
            }
            
            locationService.getCurrentLocation { location in
                Logger.viewCycle.info("Location Lat: \(location.coordinate.latitude) Location Lon: \(location.coordinate.longitude)")
                
                guard let weatherKitService = self?.injector.resolve(WeatherKitService.self) else {
                    continiation.resume(throwing: ApplicationError.notFound("WeatherKitService dependancy in injector"))
                    return
                }
                
                Task {
                    do {
                        let weatherResult = try await weatherKitService.getWeather(for: location)
                        Logger.viewCycle.info("Current Weather: \(weatherResult.currentWeather.condition.accessibilityDescription)")
                        continiation.resume(returning: weatherResult)
                    } catch {
                        continiation.resume(throwing: error)
                    }
                }
            }
        }
    }
    
    enum WeatherType {
        case day_sunny
        case day_cloudy
        case day_rainy
        case day_snow
        case night_clear
        case night_cloudy
        case night_rainy
    }
}
