//
//  StyleCollectionViewCell.swift
//  StyleWeatherPick
//
//  Created by Chris Kim on 12/30/22.
//

import SnapKit
import UIKit
import Then

class StyleCollectionViewCell: UICollectionViewCell {
    // MARK: - Vars
    static let identifier = "StyleCollectionViewCell"
    
    lazy var styleCategoryLabel = UILabel().then {
        $0.font = UIFont(name: UIFont.getRegularFont(), size: 15)
        $0.text = "상의"
        $0.textColor = .black
        $0.textAlignment = .center
    }
    
    lazy var styleImageView = UIImageView().then {
        $0.image = UIImage(named: "top")
        $0.contentMode = .scaleAspectFit
    }
    
    lazy var styleStackView = UIStackView().then {
        $0.addArrangedSubview(styleCategoryLabel)
        $0.addArrangedSubview(styleImageView)
        
        $0.axis = .vertical
        $0.distribution = .fill
        $0.alignment = .center
        $0.spacing = 10
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        addSubview(styleStackView)
        
        styleCategoryLabel.snp.makeConstraints {
            $0.top.left.equalToSuperview()
        }
        
        styleImageView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.height.equalTo(100)
            $0.width.equalTo(100)
        }
        
        styleStackView.snp.makeConstraints {
            $0.top.centerX.left.right.top.bottom.equalToSuperview()
        }
    }
}
