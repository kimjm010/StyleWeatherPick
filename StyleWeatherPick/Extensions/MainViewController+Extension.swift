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
