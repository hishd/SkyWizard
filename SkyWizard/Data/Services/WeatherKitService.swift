//
//  WKService.swift
//  SkyWizard
//
//  Created by Hishara Dilshan on 2023-10-10.
//

import Foundation
import WeatherKit
import CoreLocation
import OSLog

final class WeatherKitService {
    
    let service = WeatherService.shared
    
    public func getWeather(for location: CLLocation) async throws -> WeatherResult {
        do {
            let result = try await service.weather(for: location)
            return WeatherResult(
                currentWeather: result.currentWeather,
                hourlyForecaset: result.hourlyForecast,
                dailyForecast: result.dailyForecast
            )
        } catch {
            Logger.viewCycle.error("WeatherKit Error : \(error.localizedDescription)")
            throw ApplicationError.weatherKitError("Could not fetch weather data. Please try again")
        }
    }
}

extension WeatherKitService {
    public struct WeatherResult {
        let currentWeather: CurrentWeather
        let hourlyForecaset: Forecast<HourWeather>
        let dailyForecast: Forecast<DayWeather>
    }
}
