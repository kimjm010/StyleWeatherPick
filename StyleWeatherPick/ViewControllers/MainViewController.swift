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
    #warning("Todo: - CoreLocation -> 위치 가져오기 Geometry")
    lazy var mainWeatherView = MainWeatherView()
    
    /*
     lazy var styleCollectionView: UICollectionView = {
         let flowlayout = UICollectionViewFlowLayout()
         flowlayout.scrollDirection = .vertical
         flowlayout.minimumInteritemSpacing = 10
         flowlayout.minimumLineSpacing = 10
         flowlayout.sectionInset = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
         let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowlayout)
         collectionView.register(StyleCollectionViewCell.self,
                     forCellWithReuseIdentifier: StyleCollectionViewCell.identifier)
         collectionView.backgroundColor = .blue
         collectionView.allowsSelection = true
         collectionView.showsHorizontalScrollIndicator = false
         collectionView.isScrollEnabled = true
         collectionView.delegate = self
         collectionView.dataSource = self
         collectionView.backgroundColor = .blue
         
         return collectionView
     }()
     
     var tempData = [
         StyleWeather(styleName: "top", styleImageName: "top"),
         StyleWeather(styleName: "bottom", styleImageName: "bottom"),
         StyleWeather(styleName: "outer", styleImageName: "outer"),
         StyleWeather(styleName: "shoes", styleImageName: "shoes"),
         StyleWeather(styleName: "bag", styleImageName: "bag"),
         StyleWeather(styleName: "Accessory", styleImageName: "acc")
     ]
     */
    
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
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
            .subscribe(onNext: {
                print(#fileID, #function, #line, "- <#Comment#> \($0.1?.list.count)")
            })
            .disposed(by: disposeBag)
    }
}

extension MainViewController {
    /// Setup ScrollView
    func setupScrollView() {
        let mainWeatherView = MainWeatherView()
        
        let scrollView = UIScrollView().then {
            $0.addSubview(mainWeatherView)
//            $0.addSubview(styleCollectionView)
            
            $0.isUserInteractionEnabled = true
            $0.alwaysBounceVertical = true
        }
        
        mainWeatherView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.centerX.equalToSuperview()
        }
        
//        styleCollectionView.snp.makeConstraints {
//            $0.top.equalTo(mainWeatherView.snp.bottom).offset(10)
//            $0.left.right.equalToSuperview()
//            $0.height.equalTo(300)
//        }
        
        self.view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.center.equalToSuperview()
        }
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



/*
 extension MainViewController: UICollectionViewDelegate {
     
 }



 extension MainViewController: UICollectionViewDataSource {
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return tempData.count
     }
     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StyleCollectionViewCell.identifier,
                                                       for: indexPath) as! StyleCollectionViewCell
         let styleItem = tempData[indexPath.item]
         cell.styleCategoryLabel.text = styleItem.styleName
         cell.styleImageView.image = UIImage(named: styleItem.styleImageName)
         
         return cell
     }
 }
 
 extension MainViewController: UICollectionViewDelegateFlowLayout {
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         return CGSize(width: 150, height: 150)
     }
 }
 */







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
