//
//  SettingsView.swift
//  SkyWizard
//
//  Created by Hishara Dilshan on 2023-10-10.
//

import Foundation
import UIKit

class SettingsView: UIView {
    
    private let viewModel = SettingsViewModel()
    
    private typealias settingsCell = SettingsCell
    private let settingsCellId: String = "settingsCell"
    private lazy var mainTableView: UITableView = {
        let view = UITableView()
        view.register(settingsCell.self, forCellReuseIdentifier: settingsCellId)
        view.rowHeight = 90
        view.separatorStyle = .none
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupView() {
        mainTableView.delegate = self
        mainTableView.dataSource = self

        addSubview(mainTableView)
        mainTableView.anchor(
            top: safeAreaLayoutGuide.topAnchor,
            left: safeAreaLayoutGuide.leftAnchor,
            bottom: safeAreaLayoutGuide.bottomAnchor,
            right: safeAreaLayoutGuide.rightAnchor
        )
        
        mainTableView.reloadData()
    }
}

extension SettingsView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: settingsCellId, for: indexPath) as! SettingsCell
        let item = viewModel.options[indexPath.row]
        cell.configureView(with: item.title, iconName: item.iconName)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
