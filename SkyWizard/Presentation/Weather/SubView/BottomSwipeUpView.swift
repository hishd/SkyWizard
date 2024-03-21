//
//  BottomSwipeUpView.swift
//  SkyWizard
//
//  Created by Hishara Dilshan on 2024-03-20.
//

import UIKit
import SnapKit

enum BottomSheetViewState {
    case open
    case closed
}

extension BottomSheetViewState {
    var flippedState: BottomSheetViewState {
        return self == .open ? .closed : .open
    }
}

class BottomSwipeUpView: UIView {
    
    lazy var roundCornerHandleView: UIView = {
        let view = UIView()
        let rect = CGRect(x:-33, y: 0, width: 66, height: 6)
        let path = UIBezierPath(roundedRect: rect, cornerRadius: 10)
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.gray.cgColor
        layer.path = path.cgPath
        view.layer.addSublayer(layer)
        return view
    }()
    
    lazy var topContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .brown
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var bottomContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .brown
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupUI() {
        self.backgroundColor = .clear
        self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        self.layer.cornerRadius = 10
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.1
        self.layer.shadowRadius = 10
        
        addSubview(topContainerView)
        addSubview(bottomContainerView)
        
        //Setting up glass effect
        topContainerView.backgroundColor = .clear
        let blurEffectTop = UIBlurEffect(style: .light)
        let blurViewTop = UIVisualEffectView(effect: blurEffectTop)
        
        topContainerView.snp.makeConstraints { make in
            make.left.right.equalTo(self)
            make.top.equalTo(self)
            make.height.equalTo(164)
        }
        
        topContainerView.insertSubview(blurViewTop, at: 0)
        blurViewTop.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        topContainerView.addSubview(roundCornerHandleView)
        roundCornerHandleView.snp.makeConstraints { make in
            make.centerX.equalTo(topContainerView)
            make.top.equalTo(20)
        }
        
        bottomContainerView.snp.makeConstraints { make in
            make.left.right.equalTo(self)
            make.top.equalTo(topContainerView.snp.bottom).offset(16)
            make.height.equalTo(256)
        }
        
        bottomContainerView.backgroundColor = .clear
        let blurEffectBottom = UIBlurEffect(style: .light)
        let blurViewBottom = UIVisualEffectView(effect: blurEffectBottom)
        
        bottomContainerView.insertSubview(blurViewBottom, at: 0)
        blurViewBottom.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
