//
//  MainViewController+Extensions.swift
//  StyleWeatherPick
//
//  Created by Chris Kim on 12/18/22.
//

import SnapKit
import UIKit
import Then

extension MainViewController {
    func setupScrollView() {
        let addressLabel = UILabel().then {
            $0.font = UIFont(name: UIFont.getBoldFont(), size: 18)
            $0.text = "서울시 신림동"
            $0.textColor = .black
            $0.textAlignment = .center
        }
        
        let tempLabel = UILabel().then {
            $0.font = UIFont(name: UIFont.getExtraBoldFont(), size: 24)
            $0.text = "-1℃"
            $0.textColor = .black
            $0.textAlignment = .center
        }
        
        let descriptionLabel = UILabel().then {
            $0.font = UIFont(name: UIFont.getRegularFont(), size: 14)
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
