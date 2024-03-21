//
//  ViewController.swift
//  SkyWizard
//
//  Created by Hishara Dilshan on 2023-10-10.
//

import UIKit
import Combine
import SnapKit

class WeatherViewController: UIViewController {
    
    let primaryView = WeatherView()
    let viewModel: WeatherViewModel = WeatherViewModel()
    
    private var cancellables = Set<AnyCancellable>();
    
    let bottomSheetView = BottomSwipeUpView()
    var bottomSheetOffset: CGFloat = 190
    var bottomSheetBottomOffsetConstraint = NSLayoutConstraint()
    var bottomSheetState: BottomSheetViewState = .closed
    var bottomSheetRunningAnimator:UIViewPropertyAnimator?
    var bottomSheetAnimationProgress = CGFloat()
    lazy var bottomSheetPanGestureRecognizer: CustomPanGestureRecognizer = {
        let gestureRecognizer = CustomPanGestureRecognizer()
        gestureRecognizer.addTarget(self, action: #selector(bottomSheetPanned(recognizer:)))
        return gestureRecognizer
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(primaryView)
        navigationController?.isNavigationBarHidden = true
        primaryView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        setupBottomSheetView()
        
        setupBindings()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.primaryView.gradientBackground.frame = self.primaryView.bounds
        self.primaryView.layer.insertSublayer(self.primaryView.gradientBackground, at: 0)
    }
    
    private func setupBindings() {
        viewModel
            .$weatherType
            .receive(on: RunLoop.main)
            .sink { [weak self] type in
                self?.changeThemeColors(for: type)
                self?.changeWeatherImage(for: type)
            }
            .store(in: &cancellables)
    }
}

extension WeatherViewController {
    func setupBottomSheetView() {
        view.addSubview(bottomSheetView)
        bottomSheetView.translatesAutoresizingMaskIntoConstraints = false
        bottomSheetView.snp.makeConstraints { make in
            make.left.equalTo(additionalSafeAreaInsets).offset(20)
            make.right.equalTo(additionalSafeAreaInsets).offset(-20)
            make.height.equalTo(480)
        }
        bottomSheetBottomOffsetConstraint = bottomSheetView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottomSheetOffset)
        bottomSheetBottomOffsetConstraint.isActive = true
        bottomSheetView.addGestureRecognizer(bottomSheetPanGestureRecognizer)
    }
    
    private func animateTransitionIfNeeded(to state: BottomSheetViewState, duration: TimeInterval) {
            
        // ensure that the animators array is empty (which implies new animations need to be created)
        guard bottomSheetRunningAnimator == nil else { return }
        
        // an animator for the transition
        let transitionAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1, animations: {
            switch state {
            case .open:
                self.bottomSheetBottomOffsetConstraint.constant = 0
            case .closed:
                self.bottomSheetBottomOffsetConstraint.constant = self.bottomSheetOffset
            }
            self.view.layoutIfNeeded()
        })
        
        // the transition completion block
        transitionAnimator.addCompletion { position in
            // update the state
            switch position {
            case .start:
                self.bottomSheetState = state.flippedState
            case .end:
                self.bottomSheetState = state
            case .current:
                ()
            @unknown default:
                fatalError()
            }
            
            // manually reset the constraint positions
            switch self.bottomSheetState {
            case .open:
                self.bottomSheetBottomOffsetConstraint.constant = 0
            case .closed:
                self.bottomSheetBottomOffsetConstraint.constant = self.bottomSheetOffset
            }
            
            // remove all running animators
            self.bottomSheetRunningAnimator = nil
        }
        
        // start all animators
        transitionAnimator.startAnimation()
        
        // keep track of all running animators
        bottomSheetRunningAnimator = transitionAnimator
    }
    
    @objc private func bottomSheetPanned(recognizer: UIPanGestureRecognizer) {
            switch recognizer.state {
            case .began:
                
                // start the animations
                animateTransitionIfNeeded(to: bottomSheetState.flippedState, duration: 1)
                
                // pause all animations, since the next event may be a pan changed
                bottomSheetRunningAnimator?.pauseAnimation()
                
                // keep track of each animator's progress
                bottomSheetAnimationProgress = bottomSheetRunningAnimator?.fractionComplete ?? 0
                
            case .changed:
                
                // variable setup
                let translation = recognizer.translation(in: bottomSheetView)
                var fraction = -translation.y / bottomSheetOffset
                
                // adjust the fraction for the current state and reversed state
                if bottomSheetState == .open { fraction *= -1 }
                if let bottomSheetRunningAnimator = bottomSheetRunningAnimator {
                    if bottomSheetRunningAnimator.isReversed { fraction *= -1 }
                }
                
                // apply the new fraction
                bottomSheetRunningAnimator?.fractionComplete = fraction + bottomSheetAnimationProgress
                
                
            case .ended:
                
                // variable setup
                let yVelocity = recognizer.velocity(in: bottomSheetView).y
                let shouldClose = yVelocity > 0
                
                // if there is no motion, continue all animations and exit early
                if yVelocity == 0 {
                    bottomSheetRunningAnimator?.continueAnimation(withTimingParameters: nil, durationFactor: 0)
                    break
                }
                
                if let bottomSheetRunningAnimator = bottomSheetRunningAnimator {
                    switch bottomSheetState {
                    case .open:
                        if !shouldClose && !bottomSheetRunningAnimator.isReversed { bottomSheetRunningAnimator.isReversed = !bottomSheetRunningAnimator.isReversed }
                        if shouldClose && bottomSheetRunningAnimator.isReversed { bottomSheetRunningAnimator.isReversed = !bottomSheetRunningAnimator.isReversed }
                    case .closed:
                        if shouldClose && !bottomSheetRunningAnimator.isReversed { bottomSheetRunningAnimator.isReversed = !bottomSheetRunningAnimator.isReversed }
                        if !shouldClose && bottomSheetRunningAnimator.isReversed { bottomSheetRunningAnimator.isReversed = !bottomSheetRunningAnimator.isReversed }
                    }
                }
                // reverse the animations based on their current state and pan motion
                
                // continue all animations
                bottomSheetRunningAnimator?.continueAnimation(withTimingParameters: nil, durationFactor: 0)
                
            default:
                ()
            }
        }
}

extension WeatherViewController {
    private func changeThemeColors(for type: WeatherViewModel.WeatherType?) {
        guard let type = type else {
            return
        }
        
        switch type {
        case .day_sunny:
            changeGradientColor(colorTop: UIColor(named: "day_sunny_1"), colorBottom: UIColor(named: "day_sunny_2"), style: .darkContent)
            changeLabelColor(switchToDarkColor: true)
            break
        case .day_cloudy:
            changeGradientColor(colorTop: UIColor(named: "day_cloudy_1"), colorBottom: UIColor(named: "day_cloudy_2"), style: .darkContent)
            changeLabelColor(switchToDarkColor: true)
            break
        case .day_rainy:
            changeGradientColor(colorTop: UIColor(named: "day_rainy_1"), colorBottom: UIColor(named: "day_rainy_2"), style: .darkContent)
            changeLabelColor(switchToDarkColor: true)
            break
        case .day_snow:
            changeGradientColor(colorTop: UIColor(named: "day_snow_1"), colorBottom: UIColor(named: "day_snow_2"), style: .darkContent)
            changeLabelColor(switchToDarkColor: true)
            break
        case .night_clear:
            changeGradientColor(colorTop: UIColor(named: "night_clear_1"), colorBottom: UIColor(named: "night_clear_2"), style: .darkContent)
            changeLabelColor(switchToDarkColor: false)
            break
        case .night_cloudy:
            changeGradientColor(colorTop: UIColor(named: "night_cloudy_1"), colorBottom: UIColor(named: "night_cloudy_2"), style: .darkContent)
            changeLabelColor(switchToDarkColor: false)
            break
        case .night_rainy:
            changeGradientColor(colorTop: UIColor(named: "night_rainy_1"), colorBottom: UIColor(named: "night_rainy_2"), style: .lightContent)
            changeLabelColor(switchToDarkColor: false)
            break
        }
        
        changeHouseImage(for: type)
        
        func changeGradientColor(colorTop: UIColor?, colorBottom: UIColor?, style: UIStatusBarStyle = .default) {
            let gradientAnimation = CABasicAnimation(keyPath: "colors")
            gradientAnimation.duration = 1.0
            gradientAnimation.toValue = [
                colorTop?.cgColor ?? UIColor.black.cgColor,
                colorBottom?.cgColor ?? UIColor.black.cgColor
            ]
            gradientAnimation.fillMode = .forwards
            gradientAnimation.isRemovedOnCompletion = false
            self.primaryView.gradientBackground.add(gradientAnimation, forKey: "colorChange")
            
            if let rootController = view.window?.rootViewController as? NavigationContainer {
                rootController.changeStatusBarStyle(style: style)
            }
        }
        
        func changeLabelColor(switchToDarkColor: Bool) {
            if switchToDarkColor {
                self.primaryView.temperatureLabel.textColor = UIColor(named: "colorDark")
                self.primaryView.temperatureDegreesLabel.textColor = UIColor(named: "colorDark")
                self.primaryView.temperatureHighLabel.textColor = UIColor(named: "colorDarkGray")
                self.primaryView.temperatureHighDegreesLabel.textColor = UIColor(named: "colorDarkGray")
                self.primaryView.temperatureLowLabel.textColor = UIColor(named: "colorDarkGray")
                self.primaryView.temperatureLowDegreesLabel.textColor = UIColor(named: "colorDarkGray")
                self.primaryView.cityNameLabel.textColor = UIColor(named: "colorDarkGray")
                self.primaryView.locationButton.setImage(UIImage(named: "location_pin_dark"), for: .normal)
            } else {
                self.primaryView.temperatureLabel.textColor = .white
                self.primaryView.temperatureDegreesLabel.textColor = .white
                self.primaryView.temperatureHighLabel.textColor = .white
                self.primaryView.temperatureHighDegreesLabel.textColor = .white
                self.primaryView.temperatureLowLabel.textColor = .white
                self.primaryView.temperatureLowDegreesLabel.textColor = .white
                self.primaryView.cityNameLabel.textColor = .white
                self.primaryView.locationButton.setImage(UIImage(named: "location_pin_white"), for: .normal)
            }
        }
    }
    
    func changeWeatherImage(for type: WeatherViewModel.WeatherType?) {
        guard let type = type else {
            return
        }
        
        var image: UIImage?
        
        switch type {
        case .day_sunny:
            image = UIImage(named: "ic_day_sunny")
        case .day_cloudy:
            image = UIImage(named: "ic_day_cloudy")
        case .day_rainy:
            image = UIImage(named: "ic_day_rainy")
        case .day_snow:
            image = UIImage(named: "ic_snow")
        case .night_clear:
            image = UIImage(named: "ic_night_clear")
        case .night_cloudy:
            image = UIImage(named: "ic_night_cloudy")
        case .night_rainy:
            image = UIImage(named: "ic_night_rainy")
        }
        
        UIView.transition(with: self.primaryView.weatherImageView, duration: 1.2, options: .transitionCrossDissolve) {
            self.primaryView.weatherImageView.image = image
        }
    }
    
    func changeHouseImage(for type: WeatherViewModel.WeatherType?) {
        guard let type = type else {
            return
        }
        
        var image: UIImage?
        
        switch type {
        case .day_sunny:
            image = UIImage(named: "house_day_sunny")
        case .day_cloudy:
            image = UIImage(named: "house_day_cloudy")
        case .day_rainy:
            image = UIImage(named: "house_day_rainy")
        case .day_snow:
            image = UIImage(named: "house_day_snow")
        case .night_clear:
            image = UIImage(named: "house_night_clear")
        case .night_cloudy:
            image = UIImage(named: "house_night_cloudy")
        case .night_rainy:
            image = UIImage(named: "house_night_rainy")
        }
        
        UIView.transition(with: self.primaryView.houseImageView, duration: 1.2, options: .transitionCrossDissolve) {
            self.primaryView.houseImageView.image = image
        }
    }
}
