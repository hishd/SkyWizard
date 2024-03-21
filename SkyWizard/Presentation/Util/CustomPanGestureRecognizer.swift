//
//  CustomPanGestureRecognizer.swift
//  SkyWizard
//
//  Created by Hishara Dilshan on 2024-03-20.
//

import UIKit

class CustomPanGestureRecognizer: UIPanGestureRecognizer {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        if (self.state == UIGestureRecognizer.State.began) { return }
        super.touchesBegan(touches, with: event)
        self.state = UIGestureRecognizer.State.began
    }
}
