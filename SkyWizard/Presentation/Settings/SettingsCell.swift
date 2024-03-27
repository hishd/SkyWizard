//
//  SettingsCell.swift
//  SkyWizard
//
//  Created by Hishara Dilshan on 2023-10-11.
//

import UIKit
import SnapKit


class SettingsCell: UITableViewCell {
    
    let titleLabel: UILabel = {
       let label = UILabel()
        label.textColor = UIColor(named: "titleLabelColor")
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    let imageIcon: UIImageView = {
       let imageView = UIImageView()
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(40)
        }
        imageView.contentMode = .scaleToFill
        imageView.tintColor = UIColor(named: "titleLabelColor")
        return imageView
    }()
    
    let rightIcon: UIImageView = {
       let imageView = UIImageView(image: UIImage(systemName: "chevron.right"))
        imageView.snp.makeConstraints { make in
            make.height.equalTo(22)
        }
        imageView.contentMode = .scaleToFill
        imageView.tintColor = UIColor(named: "titleLabelColor")
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) hasn't been implemented")
    }
    
    private func setupView() {
        let view = UIView()
        view.addSubview(imageIcon)
        view.addSubview(titleLabel)
        view.addSubview(rightIcon)
        
        imageIcon.snp.makeConstraints { make in
            make.left.equalTo(view).offset(10)
            make.centerY.equalTo(view)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(view)
            make.left.equalTo(imageIcon.snp.right).offset(12)
        }
        
        rightIcon.snp.makeConstraints { make in
            make.centerY.equalTo(view)
            make.right.equalTo(view.snp.right).offset(-20)
        }
        
        addSubview(view)
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    public func configureView(with title: String, iconName: String) {
        titleLabel.text = title
        imageIcon.image = UIImage(systemName: iconName)
    }
}
