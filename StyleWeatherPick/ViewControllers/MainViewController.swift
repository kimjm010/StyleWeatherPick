//
//  MainViewController.swift
//  StyleWeatherPick
//
//  Created by Chris Kim on 12/18/22.
//

import CoreLocation
import RxSwift
import RxCocoa
import SnapKit
import UIKit
import Then

class MainViewController: UIViewController {
    // MARK: - Vars
    private let viewModel = WeatherViewModel()
    private let disposeBag = DisposeBag()
    lazy var locationManager = CLLocationManager().then {
        $0.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        $0.delegate = self
    }
    
    // MARK: - UI
    lazy var backgroundView = BackgroundView()
    lazy var mainWeatherView = MainWeatherView()
    lazy var forecastWeatherView = ForecastView()
    lazy var topStyleView = ContainerStyleView(styleTitle: "상의",
                                               styleImage: UIImage(named: "top")!)
    lazy var trouserStyleView = ContainerStyleView(styleTitle: "하의",
                                                   styleImage: UIImage(named: "trouser")!)
    lazy var outerStyleView = ContainerStyleView(styleTitle: "아우터",
                                                 styleImage: UIImage(named: "outer")!)
    lazy var shoesStyleView = ContainerStyleView(styleTitle: "신발",
                                                 styleImage: UIImage(named: "shoes")!)
    lazy var bagStyleView = ContainerStyleView(styleTitle: "가방",
                                               styleImage: UIImage(named: "bag")!)
    lazy var accStyleView = ContainerStyleView(styleTitle: "악세사리",
                                               styleImage: UIImage(named: "acc")!)
    
    lazy var firstStyleStackView = UIStackView().then {
        $0.addArrangedSubview(topStyleView)
        $0.addArrangedSubview(trouserStyleView)
        
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.alignment = .center
        $0.spacing = 5
    }
    
    lazy var secondStyleStackView = UIStackView().then {
        $0.addArrangedSubview(outerStyleView)
        $0.addArrangedSubview(shoesStyleView)
        
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.alignment = .center
        $0.spacing = 5
    }
    
    lazy var thirdStyleStackView = UIStackView().then {
        $0.addArrangedSubview(bagStyleView)
        $0.addArrangedSubview(accStyleView)
        
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.alignment = .center
        $0.spacing = 5
    }
    
    lazy var totalStyleStackView = UIStackView().then {
        $0.addArrangedSubview(firstStyleStackView)
        $0.addArrangedSubview(secondStyleStackView)
        $0.addArrangedSubview(thirdStyleStackView)
        
        $0.axis = .vertical
        $0.distribution = .fill
        $0.alignment = .center
        $0.spacing = 5
    }
    
    lazy var containerView = UIStackView().then {
        $0.addArrangedSubview(mainWeatherView)
        $0.addArrangedSubview(totalStyleStackView)
        $0.addArrangedSubview(forecastWeatherView)
        
        $0.axis = .vertical
        $0.distribution = .fill
        $0.alignment = .center
        $0.spacing = 10
        $0.backgroundColor = .clear
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    
        setupScrollView()
        setupNavBar()
        
        viewModel.getWeatherData()
        rxBind()
    }
    
    private func rxBind() {
        viewModel.weatherSubject
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: {
                $0.0.mainWeatherView.weatherData = $0.1
            })
            .disposed(by: disposeBag)
        
        viewModel.forecastSubject
            .withUnretained(self)
            .debug()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: {
                $0.0.forecastWeatherView.forecastData = $0.1
            })
            .disposed(by: disposeBag)
        
        navigationItem.rightBarButtonItem?.rx.tap
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .withUnretained(self)
            .subscribe(onNext: { _ in
                let settingVC = SettingViewController()
                self.navigationController?.pushViewController(settingVC, animated: true)
            })
            .disposed(by: disposeBag)
    }
}

extension MainViewController {
    /// Setup ScrollView
    func setupScrollView() {
        let scrollView = UIScrollView().then {
            $0.addSubview(containerView)
            
            $0.isUserInteractionEnabled = true
            $0.alwaysBounceVertical = true
//            $0.backgroundColor = .clear
        }
        
        mainWeatherView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        totalStyleStackView.snp.makeConstraints {
            $0.top.equalTo(mainWeatherView.minTempLabel.snp.bottom)
            $0.centerX.equalToSuperview()
            $0.left.right.equalToSuperview()
        }
        
        forecastWeatherView.snp.makeConstraints {
            $0.top.equalTo(totalStyleStackView.snp.bottom)
            $0.centerX.equalToSuperview()
            $0.left.right.equalToSuperview()
        }
        
        containerView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide.snp.edges)
            $0.width.equalTo(scrollView.frameLayoutGuide.snp.width)
        }
        
        self.view.addSubview(backgroundView)
        self.view.addSubview(scrollView)
        
        backgroundView.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    /// Setup NavigationBar
    func setupNavBar() {
        let rightBarButton = UIBarButtonItem(image: UIImage(named: "settings"),
                                             style: .plain,
                                             target: nil,
                                             action: #selector(goToSettings))
        rightBarButton.tintColor = .secondaryLabel
        self.navigationItem.setRightBarButton(rightBarButton, animated: true)
    }
    
    @objc
    func goToSettings() {
        let settingVC = SettingViewController()
        self.navigationController?.pushViewController(settingVC, animated: true)
    }
}




extension MainViewController: CLLocationManagerDelegate {
    func updateLocation() {
        locationManager.startUpdatingLocation()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if CLLocationManager.locationServicesEnabled() {
            switch manager.authorizationStatus {
            case .notDetermined:
                print(#fileID, #function, #line, "- <#Comment#>")
                locationManager.requestWhenInUseAuthorization()
            case .denied, .restricted:
                #warning("Todo: - 경고창")
                print(#fileID, #function, #line, "- <#Comment#>")
                break
            case .authorizedAlways, .authorizedWhenInUse:
                updateLocation()
                print(#fileID, #function, #line, "- <#Comment#>")
                break
            default:
                break
            }
        } else {
            //경고창 -> 위치정보를 사용할 수 없습니다. 설정해주세요 등...
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let current = locations.last {
            print(#fileID, #function, #line, "- <#Comment#> \(current.coordinate)")
            
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(current) { [weak self] (placemarks, error) in
                if let error = error {
                    print(#fileID, #function, #line, "- <#Comment#> \(error)")
                }
                
                if let place = placemarks?.first {
                    if let gu = place.locality,
                        let dong = place.subLocality {
                        self?.mainWeatherView.addressLabel.text = "\(gu) \(dong)"
                    } else {
                        self?.mainWeatherView.addressLabel.text = place.name
                    }
                }
            }
            
            #warning("Todo: - 위치 업데이트 -> 날씨 데이터 다시 가져오기")
            manager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#fileID, #function, #line, "- <#Comment#> \(error)")
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
