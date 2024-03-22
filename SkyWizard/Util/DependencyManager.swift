//
//  DependencyInjector.swift
//  SkyWizard
//
//  Created by Hishara Dilshan on 2023-10-10.
//

import Foundation

protocol Injectable {}

@propertyWrapper
/// Usage: @Inject var propertyName: Type (that conforms to Injectable)
struct Inject<T: Injectable> {
    var wrappedValue: T
    
    init() {
        self.wrappedValue = Resolver.shared.resolve()
    }
}

class Resolver {
    static let shared = Resolver()
    private var storage: [String: Injectable] = [:]
    
    private init() {}
    
    func add<T: Injectable>(injectable: T) {
        let key = String(reflecting: injectable)
        storage[key] = injectable
    }
    
    func resolve<T: Injectable>() -> T {
        let key = String(reflecting: T.self)
        
        guard let injectable = storage[key] as? T else {
            fatalError("Injectable not found on storage")
        }
        
        return injectable
    }
}

class DependencyManager {
    //let dependency: Type (conforms to Injectable)
    init() {
        //Resolver.shared.add(dependency)
    }
}
