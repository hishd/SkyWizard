//
//  WeatherView.swift
//  SkyWizard
//
//  Created by Hishara Dilshan on 2023-10-10.
//

import Foundation
import UIKit
import SnapKit

class WeatherView: UIView {
    
    lazy var gradientBackground: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.white.cgColor, UIColor.white.cgColor]
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 1.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        return gradient
    }()
    
    lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = FontProvider.shared.getFont(typeFace: .regular, fontSize: 78)
        label.text = "20"
        label.textColor = UIColor(named: "colorDark")
        return label
    }()
    
    lazy var temperatureDegreesLabel: UILabel = {
        let label = UILabel()
        label.font = FontProvider.shared.getFont(typeFace: .regular, fontSize: 26)
        label.text = "0"
        label.textColor = UIColor(named: "colorDark")
        return label
    }()
    
    lazy var temperatureHighLabel: UILabel = {
        let label = UILabel()
        label.font = FontProvider.shared.getFont(typeFace: .medium, fontSize: 18)
        label.text = "H 24"
        label.textColor = UIColor(named: "colorDarkGray")
        return label
    }()
    
    lazy var temperatureHighDegreesLabel: UILabel = {
        let label = UILabel()
        label.font = FontProvider.shared.getFont(typeFace: .medium, fontSize: 10)
        label.text = "0"
        label.textColor = UIColor(named: "colorDark")
        return label
    }()
    
    lazy var temperatureLowLabel: UILabel = {
        let label = UILabel()
        label.font = FontProvider.shared.getFont(typeFace: .medium, fontSize: 18)
        label.text = "L 18"
        label.textColor = UIColor(named: "colorDarkGray")
        return label
    }()
    
    lazy var temperatureLowDegreesLabel: UILabel = {
        let label = UILabel()
        label.font = FontProvider.shared.getFont(typeFace: .medium, fontSize: 10)
        label.text = "0"
        label.textColor = UIColor(named: "colorDark")
        return label
    }()
    
    lazy var cityNameLabel: UILabel = {
        let label = UILabel()
        label.font = FontProvider.shared.getFont(typeFace: .medium, fontSize: 26)
        label.text = "Northampton"
        label.textColor = UIColor(named: "colorDark")
        return label
    }()
    
    lazy var locationButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .none
        return button
    }()
    
    lazy var weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ic_day_sunny")
        return imageView
    }()
    
    lazy var houseImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "house_day_cloudy")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(temperatureLabel)
        addSubview(temperatureDegreesLabel)
        addSubview(temperatureHighLabel)
        addSubview(temperatureHighDegreesLabel)
        addSubview(temperatureLowLabel)
        addSubview(temperatureLowDegreesLabel)
        addSubview(cityNameLabel)
        addSubview(locationButton)
        addSubview(weatherImageView)
        addSubview(houseImageView)
        
        temperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(32)
            make.left.equalTo(safeAreaLayoutGuide).offset(20)
        }
        
        temperatureDegreesLabel.snp.makeConstraints { make in
            make.left.equalTo(temperatureLabel.snp.right)
            make.top.equalTo(temperatureLabel.snp.top).offset(-5)
        }
        
        temperatureHighLabel.snp.makeConstraints { make in
            make.left.equalTo(safeAreaLayoutGuide).offset(22)
            make.top.equalTo(temperatureLabel.snp.bottom).offset(8)
        }
        
        temperatureHighDegreesLabel.snp.makeConstraints { make in
            make.left.equalTo(temperatureHighLabel.snp.right)
            make.top.equalTo(temperatureHighLabel.snp.top).offset(-6)
        }
        
        temperatureLowLabel.snp.makeConstraints { make in
            make.top.equalTo(temperatureHighLabel)
            make.left.equalTo(temperatureHighLabel.snp.right).offset(28)
        }
        
        temperatureLowDegreesLabel.snp.makeConstraints { make in
            make.left.equalTo(temperatureLowLabel.snp.right)
            make.top.equalTo(temperatureLowLabel.snp.top).offset(-6)
        }
        
        cityNameLabel.snp.makeConstraints { make in
            make.left.equalTo(temperatureLabel)
            make.top.equalTo(temperatureLowLabel.snp.bottom).offset(15)
        }
        
        locationButton.snp.makeConstraints { make in
            make.centerY.equalTo(cityNameLabel)
            make.width.height.equalTo(22)
            make.left.equalTo(cityNameLabel.snp.right).offset(10)
        }
        
        weatherImageView.snp.makeConstraints { make in
            make.width.height.equalTo(168)
            make.top.equalTo(safeAreaLayoutGuide).offset(18)
            make.right.equalTo(safeAreaLayoutGuide).offset(-10)
        }
        
        houseImageView.snp.makeConstraints { make in
            make.top.equalTo(cityNameLabel.snp.bottom)
            make.left.equalTo(safeAreaLayoutGuide).offset(5)
            make.right.equalTo(safeAreaLayoutGuide).offset(-5)
            make.height.equalTo(440)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
