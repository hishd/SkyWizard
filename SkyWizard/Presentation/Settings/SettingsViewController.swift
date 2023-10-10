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
