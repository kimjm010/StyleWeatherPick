//
//  ContainerStyleView.swift
//  StyleWeatherPick
//
//  Created by Chris Kim on 2023/03/17.
//

import Foundation
import SnapKit
import UIKit
import Then

class ContainerStyleView: UIView {
    var styleTitle: String
    var styleImage: UIImage
    
    lazy var styleLabel = UILabel().then {
        $0.font = UIFont(name: UIFont.getBoldFont(), size: 15)
        $0.textColor = .secondaryLabel
        $0.textAlignment = .center
        $0.text = styleTitle
    }
    
    lazy var styleImageView = UIImageView().then {
        $0.image = styleImage
        $0.contentMode = .scaleAspectFit
    }
    
    lazy var styleStackView = UIStackView().then {
        $0.addArrangedSubview(styleLabel)
        $0.addArrangedSubview(styleImageView)
        
        $0.axis = .vertical
        $0.distribution = .fill
        $0.alignment = .center
        $0.spacing = 5
    }
    // MARK: - Initializer
    init(styleTitle: String, styleImage: UIImage) {
        self.styleTitle = styleTitle
        self.styleImage = styleImage
        super.init(frame: .zero)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        addSubview(styleStackView)
        
        styleStackView.layer.cornerRadius = 10
        
        styleStackView.snp.makeConstraints {
            $0.left.right.height.width.equalToSuperview()
        }
        
        styleLabel.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        styleImageView.snp.makeConstraints {
            $0.height.width.equalTo(100)
        }
    }
}
