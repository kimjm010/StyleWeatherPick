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
    private let disposeBag = DisposeBag()
    
    var forecastData: [Forecast.ForecastItem]? {
        didSet {
            itemEmitter.accept(forecastData ?? [])
        }
    }
    
    // MARK: - UI
    lazy var forecastLabel = UILabel().then {
        $0.textColor = .secondaryLabel
        $0.font = .systemFont(ofSize: 15, weight: .bold)
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
        super.init(frame: frame)
        
        configureUI()
        rxBind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        addSubview(forecastLabel)
        addSubview(forecastTableView)
        
        forecastLabel.snp.makeConstraints {
            $0.top.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(40)
        }
        
        forecastTableView.snp.makeConstraints {
            $0.top.equalTo(forecastLabel.snp.bottom).offset(10)
            $0.left.right.equalTo(forecastLabel.snp.horizontalEdges)
            $0.bottom.equalToSuperview()
        }
    }
    
    private func rxBind() {
        itemEmitter
            .debug()
            .bind(to: forecastTableView.rx.items(cellIdentifier: ForecastTableViewCell.identifier,
                                                 cellType: ForecastTableViewCell.self)) { (row, item, cell) in
                cell.temperatureLabel.text = item.main.temp.temperatureString
                cell.selectionStyle = .none
            }
                                                 .disposed(by: disposeBag)
    }
}
