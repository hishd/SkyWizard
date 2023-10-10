//
//  TabController.swift
//  SkyWizard
//
//  Created by Hishara Dilshan on 2023-10-10.
//

import UIKit

class TabController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //View Controllers
        let vc1 = WeatherViewController()
        let vc2 = SettingsViewController()
        
        //Setting titles for the viewControllers
        vc1.title = "Weather"
        vc2.title = "Settings"
        
        let tab1 = UINavigationController(rootViewController: vc1)
        let tab2 = UINavigationController(rootViewController: vc2)
        
        //Setting icons and tab titles
        tab1.tabBarItem = UITabBarItem(title: "Weather", image: UIImage(systemName: "cloud.sun"), tag: 0)
        tab2.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 0)
        
        
        setViewControllers(
            [
                tab1,
                tab2,
            ],
            animated: true)
    }
    
}
