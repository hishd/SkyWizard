//
//  WeatherError.swift
//  SkyWizard
//
//  Created by Hishara Dilshan on 2024-05-16.
//

import Foundation

enum WeatherError: Error {
    case errorLoading
}

extension WeatherError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .errorLoading:
            return "Could not load weather result for your location. Please try again later."
        }
    }
}
