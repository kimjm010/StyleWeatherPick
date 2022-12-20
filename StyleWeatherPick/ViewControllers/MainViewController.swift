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
    // MARK: - Vars
    var currentAddress = "서울시 신림동"
    var currentTemp = -1.0
    var weatherDescription = "청명함"
    var maxTemp = 2
    var minTemp = -9
    var currentUserStyle = Styles.MenStyles.Casual
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScrollView()
        print(#fileID, #function, #line, "- \(UIFont.getBoldFont())")
    }
}

extension MainViewController {
    
    func createTopStackView() -> UIStackView {
        let addressLabel = UILabel().then {
            $0.font = UIFont(name: UIFont.getExtraBoldFont(), size: 30)
            $0.text = "\(currentAddress)"
            $0.textColor = .white
            $0.textAlignment = .center
        }
        
        let tempLabel = UILabel().then {
            $0.font = UIFont(name: UIFont.getExtraBoldFont(), size: 35)
            $0.text = "\(currentTemp)℃"
            $0.textColor = .white
            $0.textAlignment = .center
        }
        
        let descriptionLabel = UILabel().then {
            $0.font = UIFont(name: UIFont.getRegularFont(), size: 20)
            $0.text = "\(weatherDescription)"
            $0.textColor = .white
            $0.textAlignment = .center
        }
        
        let maxTempLabel = UILabel().then {
            $0.font = UIFont(name: UIFont.getRegularFont(), size: 20)
            $0.text = "최고: \(maxTemp)"
            $0.textColor = .white
            $0.textAlignment = .center
        }
        
        let minTempLabel = UILabel().then {
            $0.font = UIFont(name: UIFont.getRegularFont(), size: 20)
            $0.text = "최처: \(minTemp)"
            $0.textColor = .white
            $0.textAlignment = .center
        }
        
        let minMaxTempStackView = UIStackView().then {
            $0.addArrangedSubview(maxTempLabel)
            $0.addArrangedSubview(minTempLabel)
            
            $0.axis = .horizontal
            $0.alignment = .center
            $0.distribution = .fill
            $0.spacing = 10
        }
        
        let topStackView = UIStackView().then {
            $0.addArrangedSubview(addressLabel)
            $0.addArrangedSubview(tempLabel)
            $0.addArrangedSubview(descriptionLabel)
            $0.addArrangedSubview(minMaxTempStackView)
            
            $0.axis = .vertical
            $0.spacing = 15
            $0.distribution = .fill
            $0.alignment = .center
        }
        
        return topStackView
    }
    
    
    private func createStyleStackView(itemLabel: String, itemImage: String? = nil) -> UIStackView {
        let itemLabel = UILabel().then {
            $0.font = UIFont(name: UIFont.getExtraBoldFont(), size: 18)
            $0.text = itemLabel
            $0.textColor = .white
            $0.textAlignment = .center
        }
        
        let itemImageView = UIImageView().then {
            #warning("Todo: - SystemImage -> CustomImage로 변경할 것")
            $0.image = UIImage(systemName: itemImage ?? "")
            $0.contentMode = .scaleAspectFit
        }
        
        let styleStackView = UIStackView().then {
            $0.addArrangedSubview(itemLabel)
            $0.addArrangedSubview(itemImageView)
            
            $0.axis = .vertical
            $0.alignment = .center
            $0.distribution = .fill
            $0.spacing = 10
        }
        
        return styleStackView
    }
    
    
    func setupScrollView() {
        let topStackView = createTopStackView()
        let topStyleView = createStyleStackView(itemLabel: "Top", itemImage: "person.fill.checkmark")
        
        let scrollView = UIScrollView().then {
//            $0.addSubview(topStackView)
//            $0.addSubview(topStyleView)
//            $0.addSubview(bottomStyleView)
//            $0.addSubview(outerStyleView)
//            $0.addSubview(shoeStyleView)
//            $0.addSubview(bagStyleView)
//            $0.addSubview(accessoryStyleView)
            
            $0.isUserInteractionEnabled = true
            $0.alwaysBounceVertical = true
        }
        
        topStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.centerX.equalToSuperview()
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
