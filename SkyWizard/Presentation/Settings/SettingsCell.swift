//
//  SettingsCell.swift
//  SkyWizard
//
//  Created by Hishara Dilshan on 2023-10-11.
//

import UIKit


class SettingsCell: UITableViewCell {
    
    let titleLabel: UILabel = {
       let label = UILabel()
        label.textColor = UIColor(named: "labelColor")
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    let imageIcon: UIImageView = {
       let imageView = UIImageView()
        imageView.setDimensions(height: 40, width: 40)
        imageView.contentMode = .scaleToFill
        imageView.tintColor = UIColor(named: "labelColor")
        return imageView
    }()
    
    let rightIcon: UIImageView = {
       let imageView = UIImageView(image: UIImage(systemName: "chevron.right"))
        imageView.setHeight(of: 22)
        imageView.contentMode = .scaleToFill
        imageView.tintColor = UIColor(named: "labelColor")
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
        
        imageIcon.anchor(left: view.leftAnchor, paddingLeft: 10)
        imageIcon.centerY(inView: view)
        titleLabel.centerY(inView: view)
        titleLabel.anchor(left: imageIcon.rightAnchor, paddingLeft: 12)
        rightIcon.centerY(inView: view)
        rightIcon.anchor(right: view.rightAnchor, paddingRight: 20)
        
        addSubview(view)
        view.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 10)
    }
    
    public func configureView(with title: String, iconName: String) {
        titleLabel.text = title
        imageIcon.image = UIImage(systemName: iconName)
    }
}
