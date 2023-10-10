//
//  ApplicationError.swift
//  SkyWizard
//
//  Created by Hishara Dilshan on 2023-10-10.
//

import Foundation


enum ApplicationError: Error {
    case notFound(String)
    case weatherKitError(String)
}

extension ApplicationError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .notFound(let text) : NSLocalizedString("\(text) not found", comment: "")
        case .weatherKitError(let message): NSLocalizedString(message, comment: "")
        }
    }
}
