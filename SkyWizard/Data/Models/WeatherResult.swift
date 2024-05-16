//
//  WeatherResult.swift
//  SkyWizard
//
//  Created by Hishara Dilshan on 2024-03-13.
//

import Foundation
import OSLog

// MARK: - WeatherResult
public struct WeatherResult: Codable {
    let latitude: Double
    let longitude: Double
    let generationTimeMS: Double
    let utcOffsetSeconds: Int
    let timezone: String
    let timezoneAbbreviation: String
    let elevation: Int
    let currentUnits: CurrentUnits
    let current: Current
    let dailyUnits: DailyUnits
    let daily: Daily

    enum CodingKeys: String, CodingKey {
        case latitude, longitude
        case generationTimeMS = "generationtime_ms"
        case utcOffsetSeconds = "utc_offset_seconds"
        case timezone
        case timezoneAbbreviation = "timezone_abbreviation"
        case elevation
        case currentUnits = "current_units"
        case current
        case dailyUnits = "daily_units"
        case daily
    }
}

// MARK: - Current
struct Current: Codable {
    let time: String
    let interval: Int
    let temperature2M: Double
    let isDay: Int
    let rain: Int
    let snowfall: Int
    let weatherCode: Int

    enum CodingKeys: String, CodingKey {
        case time, interval
        case temperature2M = "temperature_2m"
        case isDay = "is_day"
        case rain, snowfall
        case weatherCode = "weather_code"
    }
}

// MARK: - CurrentUnits
struct CurrentUnits: Codable {
    let time: String
    let interval: String
    let temperature2M: String
    let isDay: String
    let rain: String
    let snowfall: String
    let weatherCode: String

    enum CodingKeys: String, CodingKey {
        case time, interval
        case temperature2M = "temperature_2m"
        case isDay = "is_day"
        case rain, snowfall
        case weatherCode = "weather_code"
    }
}

// MARK: - Daily
struct Daily: Codable {
    let time: [String]
    let weatherCode: [Int]
    let temperature2MMax: [Double]
    let temperature2MMin: [Double]

    enum CodingKeys: String, CodingKey {
        case time
        case weatherCode = "weather_code"
        case temperature2MMax = "temperature_2m_max"
        case temperature2MMin = "temperature_2m_min"
    }
}

// MARK: - DailyUnits
struct DailyUnits: Codable {
    let time: String
    let weatherCode: String
    let temperature2MMax: String
    let temperature2MMin: String

    enum CodingKeys: String, CodingKey {
        case time
        case weatherCode = "weather_code"
        case temperature2MMax = "temperature_2m_max"
        case temperature2MMin = "temperature_2m_min"
    }
}

//MARK: Sample data
extension WeatherResult {
    static let sample: WeatherResult = {
        guard let filePath = Bundle.main.path(forResource: "sample_weather_data", ofType: "json") else {
            fatalError("Could not load data from the json file")
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: filePath))
            let result = try JSONDecoder().decode(WeatherResult.self, from: data)
            return result
        } catch {
            Logger.viewCycle.error("Could not generate sample weather result. Error: \(error.localizedDescription)")
            fatalError("Failed to generate sample result.")
        }
    }()
}
