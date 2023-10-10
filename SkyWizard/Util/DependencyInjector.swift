//
//  DependencyInjector.swift
//  SkyWizard
//
//  Created by Hishara Dilshan on 2023-10-10.
//

import Foundation
import Swinject

final class DependencyInjector {
    static let shared = DependencyInjector()
    
    private init() {}
    
    let container: Container = {
        let container = Container()
        container.register(LocationService.self) { _ in
            LocationService()
        }
        container.register(IAPService.self) { _ in
            IAPService()
        }
        container.register(WeatherKitService.self) { _ in
            WeatherKitService()
        }
        return container
    }()
}
