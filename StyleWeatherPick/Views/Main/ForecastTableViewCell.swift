//
//  ForecastTableViewCell.swift
//  StyleWeatherPick
//
//  Created by Chris Kim on 2023/03/18.
//

import SnapKit
import UIKit
import Then

class ForecastTableViewCell: UITableViewCell {
    // MARK: - Vars
    static let identifier = "ForecastTableViewCell"
    
    // MARK: - UI
    lazy var dateLabel = UILabel().then {
        $0.textColor = .secondaryLabel
    }
    
    lazy var timeLabel = UILabel().then {
        $0.textColor = .secondaryLabel
    }
    
    lazy var labelStackView = UIStackView().then {
        $0.addArrangedSubview(dateLabel)
        $0.addArrangedSubview(timeLabel)
        
        $0.axis = .vertical
        $0.distribution = .fill
        $0.alignment = .fill
        $0.spacing = 3
    }
    
    lazy var iconImageView = UIImageView().then {
        $0.backgroundColor = .clear
    }
    
    lazy var descriptionLabel = UILabel().then {
        $0.textColor = .secondaryLabel
    }
    
    lazy var temperatureLabel = UILabel().then {
        $0.textColor = .secondaryLabel
    }
    
    lazy var forecastStackView = UIStackView().then {
        $0.addArrangedSubview(labelStackView)
        $0.addArrangedSubview(iconImageView)
        $0.addArrangedSubview(descriptionLabel)
        $0.addArrangedSubview(temperatureLabel)
        
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.alignment = .center
        $0.spacing = 3
    }
    
    var forecastItem: Forecast.ForecastItem?
//    {
//        didSet {
//            dateLabel.text = forecastItem?.date.dateToString
//            timeLabel.text = forecastItem?.date.timeToString
//            temperatureLabel.text = forecastItem?.main.temp.temperatureString
//            descriptionLabel.text = forecastItem?.weather.first?.description
//            iconImageView.image = UIImage(named: "\(forecastItem?.weather.first?.icon ?? "")")
//        }
//    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        addSubview(labelStackView)
        addSubview(iconImageView)
        addSubview(descriptionLabel)
        addSubview(temperatureLabel)
        
        temperatureLabel.snp.makeConstraints {
            $0.right.equalToSuperview()
            $0.top.bottom.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.right.equalTo(temperatureLabel.snp.left).inset(5)
            $0.top.bottom.equalToSuperview()
        }
        
        iconImageView.snp.makeConstraints {
            $0.right.equalTo(descriptionLabel.snp.left).inset(5)
            $0.top.bottom.equalToSuperview()
        }
        
        labelStackView.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.right.equalTo(iconImageView.snp.left).inset(5)
            $0.top.bottom.equalToSuperview()
        }
    }
}
