//
//  UserDefaults+Extensions.swift
//  SkyWizard
//
//  Created by Hishara Dilshan on 2024-03-21.
//

import Foundation

extension UserDefaults {
    var isDebuggingEnabled: Bool {
        get {
            UserDefaults.standard.bool(forKey: "isDebuggingEnabled")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "isDebuggingEnabled")
        }
    }
}
