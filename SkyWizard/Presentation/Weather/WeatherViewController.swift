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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(primaryView)
        navigationController?.isNavigationBarHidden = true
        primaryView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
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
        
        UIView.transition(with: self.primaryView.weatherImage, duration: 1.2, options: .transitionCrossDissolve) {
            self.primaryView.weatherImage.image = image
        }
    }
}
