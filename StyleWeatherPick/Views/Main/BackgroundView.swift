//
//  BackgroundView.swift
//  StyleWeatherPick
//
//  Created by Chris Kim on 12/21/22.
//

import SnapKit
import UIKit
import Then


class BackgroundView: UIView {
    lazy var backgroundImageView = UIImageView().then {
        $0.image = UIImage(systemName: "cloud")
        $0.contentMode = .scaleAspectFit
    }
    
    lazy var dimmingView = UIView().then {
        $0.backgroundColor = .black
        $0.alpha = 0.5
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureUI() {
        addSubview(backgroundImageView)
        backgroundImageView.addSubview(dimmingView)
        
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        dimmingView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        
    }
}
