//
//  AppConfig.swift
//  SkyWizard
//
//  Created by Hishara Dilshan on 2024-03-21.
//

import Foundation

@dynamicMemberLookup
struct AppConfig {
    
    let weatherApiKey: String = ""
    
    private init() {}
    
    static func toggleDebugMode() -> Bool {
        guard !UserDefaults.standard.isDebuggingEnabled else {
            return false
        }
        
        enableDebugMode()
        
        func enableDebugMode() -> Never {
            UserDefaults.standard.isDebuggingEnabled = true
            exit(0)
        }
    }
    
    static subscript<T>(dynamicMember keyPath:KeyPath<AppConfig, T>) -> T {
        AppConfig()[keyPath: keyPath]
    }
}
