//
//  SettingsViewController.swift
//  SkyWizard
//
//  Created by Hishara Dilshan on 2023-10-10.
//

import UIKit

class SettingsViewController: UIViewController {
    
    let primaryView = SettingsView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(primaryView)
        primaryView.fillSuperViewSafeArea()
    }
}

class SettingsViewModel {
    let options: [SettingsOptions] = SettingsOptions.allCases
}

enum SettingsOptions: CaseIterable {
    case upgradePlan
    case privacyPolicy
    case terms
    case about
    case rateApp
}

extension SettingsOptions {
    var title: String {
        switch self {
        case .upgradePlan:
            "Upgrade Plan"
        case .privacyPolicy:
            "View Privacy Policy"
        case .terms:
            "Terms & Conditions"
        case .about:
            "About App"
        case .rateApp:
            "Rate Application"
        }
    }
    
    var iconName: String {
        switch self {
        case .upgradePlan:
            "dollarsign.circle"
        case .privacyPolicy:
            "hand.raised.circle"
        case .terms:
            "doc.circle"
        case .about:
            "exclamationmark.circle"
        case .rateApp:
            "star.circle"
        }
    }
}
