//
//  MainViewController.swift
//  StyleWeatherPick
//
//  Created by Chris Kim on 12/18/22.
//

import RxSwift
import RxCocoa
import SnapKit
import UIKit
import Then

class MainViewController: UIViewController {
    
    lazy var styleCollectionView = UICollectionView().then {
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.scrollDirection = .vertical
        flowlayout.minimumInteritemSpacing = 0
        flowlayout.minimumLineSpacing = 0
        flowlayout.sectionInset = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        flowlayout.itemSize = CGSize(width: 300, height: 300)
        $0.register(StyleCollectionViewCell.self,
                    forCellWithReuseIdentifier: StyleCollectionViewCell.identifier)
        $0.backgroundColor = .blue
        $0.allowsSelection = true
        $0.showsHorizontalScrollIndicator = false
        $0.isScrollEnabled = true
        $0.delegate = self
        $0.dataSource = self
    }
    
    var tempData = [
        StyleWeather(styleName: "top", styleImageName: "top"),
        StyleWeather(styleName: "bottom", styleImageName: "bottom"),
        StyleWeather(styleName: "outer", styleImageName: "outer"),
        StyleWeather(styleName: "shoes", styleImageName: "shoes"),
        StyleWeather(styleName: "bag", styleImageName: "bag"),
        StyleWeather(styleName: "Accessory", styleImageName: "acc")
    ]
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScrollView()
    }
}

extension MainViewController {
    /// Setup ScrollView
    func setupScrollView() {
        let mainWeatherView = MainWeatherView()
        
        let scrollView = UIScrollView().then {
            $0.addSubview(mainWeatherView)
            $0.addSubview(styleCollectionView)
            
            $0.isUserInteractionEnabled = true
            $0.alwaysBounceVertical = true
        }
        
        mainWeatherView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.centerX.equalToSuperview()
        }
        
        styleCollectionView.snp.makeConstraints {
            $0.top.equalTo(mainWeatherView.snp.bottom).offset(10)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(300)
        }
        
        self.view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.center.equalToSuperview()
        }
    }
}




extension MainViewController: UICollectionViewDelegate {
    
}



extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tempData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StyleCollectionViewCell.identifier, for: indexPath) as! StyleCollectionViewCell
        let styleItem = tempData[indexPath.item]
        cell.styleCategoryLabel.text = styleItem.styleName
        cell.styleImageView.image = UIImage(named: styleItem.styleImageName)
        
        return cell
    }
}



extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
    }
}
