//
//  Service.swift
//  StyleWeatherPick
//
//  Created by Chris Kim on 2023/03/15.
//

import RxAlamofire
import Foundation
import RxSwift

class Network {
    static let shared = Network()
    private init() { }
    
    private let apiKey = Bundle.main.infoDictionary?["API_KEY"] ?? ""
    private let disposeBag = DisposeBag()
    private let latitude = 37.5172
    private let longitude = 127.0473
    private let units = "metric"
    private var currentWeatherBaseUrl: String {
        return "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=\(units)"
    }
    
    private var forecastWeatherBaseUrl: String {
        return "https://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=\(units)"
    }
    
    func fetchCurrentWeatherData() -> Observable<WeatherSummary> {
        return Observable.create { (observer) in
            RxAlamofire.requestData(.get, self.currentWeatherBaseUrl)
                .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
                .filter { 200..<300 ~= $0.0.statusCode }
                .subscribe(onNext: {
                    do {
                        let result = try JSONDecoder().decode(WeatherSummary.self, from: $0.1)
                        observer.onNext(result)
                    } catch {
                        print(error)
                    }
                })
                .disposed(by: self.disposeBag)
            
            return Disposables.create()
        }
    }
    
    
    func fetchForecastWeatherData() -> Observable<Data> {
        return Observable.create { (observer) in
            RxAlamofire.requestData(.get, self.forecastWeatherBaseUrl)
                .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
                .filter { 200..<300 ~= $0.0.statusCode }
                .subscribe(onNext: {
                    observer.onNext($0.1)
                })
                .disposed(by: self.disposeBag)
            
            return Disposables.create()
        }
    }
}
