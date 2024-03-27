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
    
    private lazy var roundCornerHandle: UIView = {
        let view = UIView()
        let rect = CGRect(x: 0, y: 0, width: 66, height: 6)
        let layer = CAShapeLayer()
        layer.frame = rect
        layer.backgroundColor = UIColor.gray.cgColor
        layer.cornerRadius = 3
        view.layer.addSublayer(layer)
        return view
    }()
    
    lazy var roundCornerHandleView: UIView = {
        let view = UIView()
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 12).cgPath
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
            make.top.equalTo(topContainerView)
            make.left.right.equalTo(topContainerView)
            make.height.equalTo(60)
        }
        
        roundCornerHandleView.addSubview(roundCornerHandle)
        roundCornerHandle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(20)
            make.width.equalTo(66)
            make.height.equalTo(6)
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
