//
//  WeatherViewModel.swift
//  SkyWizard
//
//  Created by Hishara Dilshan on 2023-10-18.
//

import Foundation
import OSLog
import Combine

class WeatherViewModel {
        
    @Published private(set) var weatherType: WeatherType?
    var cancellable: AnyCancellable?
    
    init() {
        weatherType = .day_sunny

//        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
//            self?.weatherType = .day_rainy
//        }
        
//        cancellable = Timer.publish(every: 2, on: .main, in: .common)
//            .autoconnect()
//            .sink { _ in
//                DispatchQueue.main.async { [weak self] in
//                    self?.weatherType = WeatherType.allCases.randomElement()
//                }
//            }
    }
    
    private func getWeatherForCurrentLocation() async throws -> WeatherResult? {
        return nil
    }
}
