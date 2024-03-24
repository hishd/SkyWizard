//
//  HourlyWeathrViewController.swift
//  SkyWizard
//
//  Created by Hishara Dilshan on 2024-03-26.
//

import Foundation
import UIKit
import SnapKit
import Combine

final class HourlyWeatherViewController: UIViewController {
    
    private lazy var cellReuseIdentifier = String(describing: type(of: HourlyWeatherViewCell.self))
    private let cellWidth: CGFloat = 60
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 8
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(HourlyWeatherViewCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    private lazy var cellData: [HourlyWeatherItem] = []
    var cancellables = Set<AnyCancellable>()
    
    let animationDuration: Double = 0.5
    let delayBase: Double = 0.1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension HourlyWeatherViewController {
    private func setupUI() {
        view.addSubview(collectionView)
        collectionView.backgroundColor = .clear
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
        }
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func populateData(data: [HourlyWeatherItem]) {
        self.cellData = data
        collectionView.reloadData()
    }
}

extension HourlyWeatherViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! HourlyWeatherViewCell
        cell.setData(item: cellData[indexPath.row])
        cell.alpha = 0
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let delay = sqrt(Double(indexPath.row)) * delayBase
        UIView.animate(withDuration: animationDuration, delay: delay, options: .curveEaseOut, animations: {
          cell.alpha = 1
        })
    }
}

extension HourlyWeatherViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 20.0, left: 4, bottom: 1.0, right: 4)
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewHeight = collectionView.bounds.size.height
        return CGSize(width: cellWidth, height: viewHeight - 10)
    }
}
