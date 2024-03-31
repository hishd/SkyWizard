//
//  HourlyWeatherViewCell.swift
//  SkyWizard
//
//  Created by Hishara Dilshan on 2024-03-26.
//

import Foundation
import UIKit

final class HourlyWeatherViewCell: UICollectionViewCell {
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = FontProvider.shared.getFont(typeFace: .medium, fontSize: 18)
        label.text = "10 am"
        label.textColor = .colorDark
        return label
    }()
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = FontProvider.shared.getFont(typeFace: .semiBold, fontSize: 20)
        label.text = "22"
        label.textColor = .colorDarkGray
        return label
    }()
    
    private lazy var temperatureLowDegreesLabel: UILabel = {
        let label = UILabel()
        label.font = FontProvider.shared.getFont(typeFace: .semiBold, fontSize: 12)
        label.text = "0"
        label.textColor = .colorDarkGray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
        backgroundColor = .clear
        addSubview(timeLabel)
        
        timeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(8)
        }
        
        addSubview(iconImageView)
        
        iconImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.height.equalTo(36)
            make.top.equalTo(timeLabel.snp.bottom).offset(10)
        }
        
        addSubview(temperatureLabel)
        
        temperatureLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(iconImageView.snp.bottom).offset(10)
        }
        
        addSubview(temperatureLowDegreesLabel)
        
        temperatureLowDegreesLabel.snp.makeConstraints { make in
            make.left.equalTo(temperatureLabel.snp.right).offset(4)
            make.top.equalTo(temperatureLabel.snp.top).offset(-6)
        }
    }
    
    func setData(item: HourlyWeatherItem) {
        self.timeLabel.text = item.time
        self.iconImageView.image = item.image
        self.temperatureLabel.text = "\(item.temperature)"
    }
}
