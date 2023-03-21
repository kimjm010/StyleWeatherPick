//
//  ForecastView.swift
//  StyleWeatherPick
//
//  Created by Chris Kim on 2023/03/18.
//

import Foundation
import RxSwift
import RxCocoa
import SnapKit
import UIKit
import Then

class ForecastView: UIView {
    // MARK: - Vars
    private var itemEmitter = BehaviorRelay<[Forecast.ForecastItem]>(value: [])
    private let viewModel = WeatherViewModel()
    private let disposeBag = DisposeBag()
    
    var forecastData: [Forecast.ForecastItem]? {
        didSet {
            itemEmitter.accept(forecastData ?? [])
        }
    }
    
    // MARK: - UI
    lazy var forecastLabel = UILabel().then {
        $0.textColor = .secondaryLabel
        $0.font = .systemFont(ofSize: 25, weight: .bold)
        $0.text = "Weather Forecast"
    }
    
    lazy var forecastTableView: UITableView = {
       let tableView = UITableView()
        tableView.register(ForecastTableViewCell.self,
                           forCellReuseIdentifier: ForecastTableViewCell.identifier)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.separatorStyle = .singleLine
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.alwaysBounceVertical = false
        tableView.bounces = false
        tableView.rowHeight = UITableView.automaticDimension
        
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureUI()
        rxBind()
        print(#fileID, #function, #line, "- <#Comment#> \(forecastData?.count)")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        addSubview(forecastLabel)
        addSubview(forecastTableView)
        
        forecastLabel.snp.makeConstraints {
            $0.top.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(55)
        }
        
        forecastTableView.snp.makeConstraints {
            $0.top.equalTo(forecastLabel.snp.bottom).offset(10)
            $0.left.right.equalTo(forecastLabel.snp.horizontalEdges)
//            $0.bottom.equalToSuperview()
            $0.height.equalTo(400)
        }
    }
    
    private func rxBind() {
        viewModel.forecastSubject
            .subscribe(onNext: {
                print(#fileID, #function, #line, "- <#Comment#> \($0?.count)")
            })
            .disposed(by: disposeBag)
    }
}
