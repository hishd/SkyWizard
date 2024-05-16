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
    
    let httpService: HttpWebService = HttpWebService()
    
    func getWeather(for location: CLLocation) -> AnyPublisher<WeatherResult, WeatherError> {
        return Future { [weak self] promise in
            guard let strongSelf = self else {
                promise(.failure(.errorLoading))
                return
            }
            
            let queryItems: [URLQueryItem] = [
                .init(name: "latitude", value: String(location.coordinate.latitude)),
                .init(name: "longitude", value: String(location.coordinate.longitude)),
                .init(name: "current", value: "temperature_2m,is_day,rain,snowfall,weather_code"),
                .init(name: "daily", value: "weather_code,temperature_2m_max,temperature_2m_min"),
                .init(name: "timezone", value: "auto"),
            ]
            
            guard let url = URL(string: URLEndpoints.openMetroWeatherUrl) else {
                promise(.failure(.errorLoading))
                return
            }
            
            Task {
                do {
                    let resource = Resource(url: url, method: .get(queryItems))
                    let result: WeatherResult = try await strongSelf.httpService.load(resource)
                    promise(.success(result))
                } catch {
                    Logger.viewCycle.error("Error Loading Weather Response. Error: \(error.localizedDescription)")
                    throw error
                }
            }
        }.eraseToAnyPublisher()
    }
    
    public func getWeather(for location: CLLocation) async throws -> WeatherResult {
        let queryItems: [URLQueryItem] = [
            .init(name: "latitude", value: String(location.coordinate.latitude)),
            .init(name: "longitude", value: String(location.coordinate.longitude)),
            .init(name: "current", value: "temperature_2m,is_day,rain,snowfall,weather_code"),
            .init(name: "daily", value: "weather_code,temperature_2m_max,temperature_2m_min"),
            .init(name: "timezone", value: "auto"),
        ]
        
        guard let url = URL(string: URLEndpoints.openMetroWeatherUrl) else {
            throw NetworkError.badUrl
        }
        
        do {
            let resource = Resource(url: url, method: .get(queryItems))
            let result: WeatherResult = try await httpService.load(resource)
            return result
        } catch {
            Logger.viewCycle.error("Error Loading Weather Response. Error: \(error.localizedDescription)")
            throw error
        }
    }
}
