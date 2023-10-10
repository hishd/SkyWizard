//
//  ViewController.swift
//  SkyWizard
//
//  Created by Hishara Dilshan on 2023-10-10.
//

import UIKit

class WeatherViewController: UIViewController {
    
    let primaryView = WeatherView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(primaryView)
        primaryView.fillSuperViewSafeArea()
    }


}

