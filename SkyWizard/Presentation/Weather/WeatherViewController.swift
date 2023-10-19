//
//  ViewController.swift
//  SkyWizard
//
//  Created by Hishara Dilshan on 2023-10-10.
//

import UIKit
import Combine

class WeatherViewController: UIViewController {
    
    let primaryView = WeatherView()
    let viewModel: WeatherViewModel = WeatherViewModel()
    
    private var cancellables = Set<AnyCancellable>();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(primaryView)
        primaryView.fillSuperView()
        
        setupBindings()
        
        Task {
            await getWeather()
        }
    }
    
    private func getWeather() async {
        do {
//            let result: WeatherResult = try await getWeatherForCurrentLocation()
//            dump(result)
//            primaryView.loadWeatherData()
        } catch {
            showMessage(title: "Error", message: error.localizedDescription)
        }
    }
    
    private func setupBindings() {
        viewModel
            .$weatherType
            .receive(on: RunLoop.main)
            .sink { [weak self] type in
                self?.changeBackground(for: type)
            }
            .store(in: &cancellables)
    }
    
    private func changeBackground(for type: WeatherViewModel.WeatherType?) {
        guard let type = type else {
            return
        }
        
        switch type {
        case .day_sunny:
            changeColor(colorTop: UIColor(named: "day_sunny_1"), colorBottom: UIColor(named: "day_sunny_2"), style: .darkContent)
            break
        case .day_cloudy:
            changeColor(colorTop: UIColor(named: "day_cloudy_1"), colorBottom: UIColor(named: "day_cloudy_2"), style: .darkContent)
            break
        case .day_rainy:
            changeColor(colorTop: UIColor(named: "day_rainy_1"), colorBottom: UIColor(named: "day_rainy_2"), style: .darkContent)
            break
        case .day_snow:
            changeColor(colorTop: UIColor(named: "day_snow_1"), colorBottom: UIColor(named: "day_snow_2"), style: .darkContent)
            break
        case .night_clear:
            changeColor(colorTop: UIColor(named: "night_clear_1"), colorBottom: UIColor(named: "night_clear_2"), style: .darkContent)
            break
        case .night_cloudy:
            changeColor(colorTop: UIColor(named: "night_cloudy_1"), colorBottom: UIColor(named: "night_cloudy_2"), style: .darkContent)
            break
        case .night_rainy:
            changeColor(colorTop: UIColor(named: "night_rainy_1"), colorBottom: UIColor(named: "night_rainy_2"), style: .lightContent)
            break
        }
        
        func changeColor(colorTop: UIColor?, colorBottom: UIColor?, style: UIStatusBarStyle = .default) {
            
            self.primaryView.gradientBackground.colors = [
                colorTop?.cgColor ?? UIColor.black.cgColor,
                colorBottom?.cgColor ?? UIColor.black.cgColor
            ]
            self.primaryView.gradientBackground.frame = self.primaryView.bounds
            self.primaryView.layer.insertSublayer(self.primaryView.gradientBackground, at: 0)
            
            if let rootController = view.window?.rootViewController as? NavigationContainer {
                rootController.changeStatusBarStyle(style: style)
            }
        }
    }
}
