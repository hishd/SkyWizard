//
//  UserDefaults+Wrapper.swift
//  SkyWizard
//
//  Created by Hishara Dilshan on 2023-10-22.
//

import Foundation
import Combine

protocol AnyOptional {
    var isNil: Bool {get}
}

extension Optional: AnyOptional {
    var isNil: Bool {
        return self == nil
    }
}

@propertyWrapper
struct UserDefault<Value> {
    
    let key: String
    var defaultValue: Value
    var container: UserDefaults = UserDefaults.standard
    
    private let publisher = PassthroughSubject<Value, Error>()
    
    var wrappedValue: Value {
        get {
            container.object(forKey: key) as? Value ?? defaultValue
        }
        set {
            if let value = newValue as? AnyOptional, value.isNil {
                container.removeObject(forKey: key)
            } else {
                container.set(newValue, forKey: key)
            }
        }
    }
    
    var projectedValue: AnyPublisher<Value, Error> {
        publisher.eraseToAnyPublisher()
    }
}

extension UserDefault where Value: ExpressibleByNilLiteral {
    init(key: String,_ container: UserDefaults = UserDefaults.standard) {
        self.init(key: key, defaultValue: nil, container: container)
    }
}
