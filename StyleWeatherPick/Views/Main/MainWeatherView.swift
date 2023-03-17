//
//  MainWeatherView.swift
//  StyleWeatherPick
//
//  Created by Chris Kim on 12/21/22.
//

import RxSwift
import RxCocoa
import SnapKit
import UIKit
import Then

/// 날씨 정보 뷰
class MainWeatherView: UIView {
    // MARK: - Vars
    private var itemEmitter = BehaviorRelay<WeatherSummary?>(value: nil)
    private let disposeBag = DisposeBag()
    
    var weatherData: WeatherSummary? {
        didSet {
            itemEmitter.accept(weatherData ?? nil)
        }
    }
    lazy var addressLabel = UILabel().then {
        $0.font = UIFont(name: UIFont.getExtraBoldFont(), size: 30)
        $0.text = "서울시 신림동"
        $0.textColor = .secondaryLabel
        $0.textAlignment = .center
    }
    
    lazy var tempLabel = UILabel().then {
        $0.font = UIFont(name: UIFont.getExtraBoldFont(), size: 35)
        $0.textColor = .secondaryLabel
        $0.textAlignment = .center
    }
    
    lazy var descriptionLabel = UILabel().then {
        $0.font = UIFont(name: UIFont.getRegularFont(), size: 20)
        $0.textColor = .secondaryLabel
        $0.textAlignment = .center
    }
    
    lazy var feels_likeTempLabel = UILabel().then {
        $0.font = UIFont(name: UIFont.getRegularFont(), size: 20)
        
        $0.textColor = .secondaryLabel
        $0.textAlignment = .center
    }
    
    lazy var maxTempLabel = UILabel().then {
        $0.font = UIFont(name: UIFont.getRegularFont(), size: 20)
//        $0.text = "최고: 2"
        $0.textColor = .secondaryLabel
        $0.textAlignment = .center
    }
    
    lazy var minTempLabel = UILabel().then {
        $0.font = UIFont(name: UIFont.getRegularFont(), size: 20)
//        $0.text = "최처: -9"
        $0.textColor = .secondaryLabel
        $0.textAlignment = .center
    }
    
    lazy var minMaxTempStackView = UIStackView().then {
        $0.addArrangedSubview(maxTempLabel)
        $0.addArrangedSubview(minTempLabel)
        
        $0.axis = .horizontal
        $0.alignment = .center
        $0.distribution = .fill
        $0.spacing = 10
    }
    
    lazy var topStackView = UIStackView().then {
        $0.addArrangedSubview(addressLabel)
        $0.addArrangedSubview(tempLabel)
        $0.addArrangedSubview(descriptionLabel)
        $0.addArrangedSubview(feels_likeTempLabel)
        $0.addArrangedSubview(minMaxTempStackView)
        
        $0.axis = .vertical
        $0.spacing = 10
        $0.distribution = .fill
        $0.alignment = .center
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureUI()
        rxBind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func rxBind() {
        itemEmitter
            .withUnretained(self)
            .subscribe(onNext: {
                $0.0.tempLabel.text = "\($0.1?.main.temp ?? 0) ℃"
                $0.0.descriptionLabel.text = "\($0.1?.weather.first?.description ?? "")"
                $0.0.feels_likeTempLabel.text = "체감온도: \($0.1?.main.feels_like ?? 0) ℃"
                $0.0.maxTempLabel.text = "최고: \($0.1?.main.temp_max ?? 0)"
                $0.0.minTempLabel.text = "최저: \($0.1?.main.temp_min ?? 0)"
            })
            .disposed(by: disposeBag)
    }
    
    /// ConfigureUI
    private func configureUI() {
        self.backgroundColor = .clear
        addSubview(topStackView)
        
        addressLabel.snp.makeConstraints {
            $0.top.left.equalToSuperview()
        }
        
        topStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(180)
        }
    }
}
