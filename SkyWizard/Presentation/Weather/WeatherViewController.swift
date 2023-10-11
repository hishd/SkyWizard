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
    let injector = DependencyInjector.shared.container
    
    typealias WeatherResult = WeatherKitService.WeatherResult

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(primaryView)
        primaryView.fillSuperViewSafeArea()
        
        Task {
            await getWeather()
        }
    }
    
    private func getWeather() async {
        do {
//            let result: WeatherResult = try await getWeatherForCurrentLocation()
//            dump(result)
        } catch {
            showMessage(title: "Error", message: error.localizedDescription)
        }
    }
    
    private func getWeatherForCurrentLocation() async throws -> WeatherKitService.WeatherResult {
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
}
