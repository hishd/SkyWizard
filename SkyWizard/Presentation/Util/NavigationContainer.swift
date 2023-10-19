//
//  NavigationContainer.swift
//  SkyWizard
//
//  Created by Hishara Dilshan on 2023-10-19.
//

import Foundation
import UIKit


class NavigationContainer: UINavigationController {
    
    private var currentStyle: UIStatusBarStyle = .default
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return currentStyle
    }
    
    public func changeStatusBarStyle(style: UIStatusBarStyle) {
        if style == currentStyle {
            return
        }
        
        currentStyle = style
        setNeedsStatusBarAppearanceUpdate()
    }
}
