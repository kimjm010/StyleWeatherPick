//
//  WeatherViewModel.swift
//  StyleWeatherPick
//
//  Created by Chris Kim on 2023/03/17.
//

import RxAlamofire
import Foundation
import RxSwift
import RxCocoa

typealias ErrorInfo<T> = (error: Error, type: T?)

class WeatherViewModel {
    var weatherSubject = BehaviorSubject<WeatherSummary?>(value: nil)
    var forecastSubject = BehaviorSubject<Forecast?>(value: nil)
    private let disposeBag = DisposeBag()
    
    func getWeatherData() {
        Network.shared.fetchCurrentWeatherData()
            .withUnretained(self)
            .debug()
            .subscribe(onNext: {
                $0.0.weatherSubject.onNext($0.1)
            })
            .disposed(by: disposeBag)
        
        Network.shared.fetchForecastWeatherData()
            .withUnretained(self)
            .debug()
            .subscribe(onNext: {
                do {
                    let result = try JSONDecoder().decode(Forecast.self, from: $0.1)
                    print(#fileID, #function, #line, "- <#Comment#> \($0.1) \(result)")
                    $0.0.forecastSubject.onNext(result)
                } catch {
                    print(error)
                }
            })
            .disposed(by: disposeBag)
    }
}



extension WeatherViewModel {
    enum ErrorResult: Error {
        case weatherInfo
    }
    
    struct Input {
        
    }
    
    struct Output {
        let error = PublishRelay<ErrorInfo<ErrorResult>>()
        let resWeatherData = PublishRelay<WeatherSummary>()
    }
}
