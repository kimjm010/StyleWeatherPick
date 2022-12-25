//
//  MainViewController.swift
//  StyleWeatherPick
//
//  Created by Chris Kim on 12/18/22.
//

import SnapKit
import UIKit
import Then


class MainViewController: UIViewController {
    lazy var firstHorizontaoStyleView = UIStackView().then {
        $0.addArrangedSubview(TopStyleView())
        $0.addArrangedSubview(BottomStyleView())
        
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.alignment = .center
        $0.spacing = 20
    }
    
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
//        let topStyleView = TopStyleView()
        
        let scrollView = UIScrollView().then {
            $0.addSubview(mainWeatherView)
            $0.addSubview(firstHorizontaoStyleView)
            
            $0.isUserInteractionEnabled = true
            $0.alwaysBounceVertical = true
        }
        
        mainWeatherView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.centerX.equalToSuperview()
        }
        
        firstHorizontaoStyleView.snp.makeConstraints {
//            $0.top.equalTo(mainWeatherView.topStackView.snp.bottom).offset(-20)
            $0.top.equalTo(mainWeatherView.snp.bottom)
            $0.centerX.equalToSuperview()
            $0.edges.equalToSuperview()
        }
        
        self.view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.center.equalToSuperview()
        }
    }
}


#if DEBUG

import SwiftUI

struct MainViewControllerPresentable: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        MainViewController()
    }
}


struct MainViewControllerPresentable_PreviewProvider: PreviewProvider {
    static var previews: some View {
        MainViewControllerPresentable()
            .previewDevice("iPhone 12")
            .ignoresSafeArea()
    }
}

#endif
