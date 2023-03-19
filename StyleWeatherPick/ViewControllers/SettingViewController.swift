//
//  SettingViewController.swift
//  StyleWeatherPick
//
//  Created by Chris Kim on 1/3/23.
//

import SnapKit
import UIKit
import Then

class SettingViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemGray6
        
        configuerUI()
        printFont()
    }
    
    private func printFont() {
        for family in UIFont.familyNames {
            print("\(family)")
            
            for names in UIFont.fontNames(forFamilyName: family) {
            print("== \(names)")
                
            }
        }
    }
}




extension SettingViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    private func configuerUI() {
        let genderStackView = createGenderStackView()
        let ageStackView = createAgeStackView()
        let activityStackView = createActivityStackView()
        let timeStackView = createTimeStackView()
        let sensitivityStackView = createSentivityStackView()
        let stylePickerView = createStyleStackView()
        
        lazy var settingStackView = UIStackView().then {
            $0.addArrangedSubview(genderStackView)
            $0.addArrangedSubview(ageStackView)
            $0.addArrangedSubview(activityStackView)
            $0.addArrangedSubview(timeStackView)
            $0.addArrangedSubview(sensitivityStackView)
            $0.addArrangedSubview(stylePickerView)
            
            $0.axis = .vertical
            $0.alignment = .leading
            $0.distribution = .fill
            $0.spacing = 20
            $0.backgroundColor = .clear
        }
        
        lazy var scrollView = UIScrollView().then {
            $0.addSubview(settingStackView)
            
            $0.isUserInteractionEnabled = true
            $0.alwaysBounceVertical = true
            $0.backgroundColor = .clear
        }
        
        self.view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
        
        genderStackView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        ageStackView.snp.makeConstraints {
            $0.left.right.equalTo(genderStackView)
        }
        
        activityStackView.snp.makeConstraints {
            $0.left.right.equalTo(genderStackView)
        }
        
        timeStackView.snp.makeConstraints {
            $0.left.right.equalTo(genderStackView)
        }
        
        sensitivityStackView.snp.makeConstraints {
            $0.left.right.equalTo(genderStackView)
        }
        
        stylePickerView.snp.makeConstraints {
            $0.left.right.equalTo(genderStackView)
        }
        
        settingStackView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide.snp.edges)
            $0.width.equalTo(scrollView.frameLayoutGuide.snp.width)
        }
    }
    
    /// Create Gender Stack View
    /// - Returns: UIStackView object
    private func createGenderStackView() -> UIStackView {
        lazy var genderLabel = UILabel().then {
            $0.text = "Gender"
            $0.font = UIFont.returnNanumGothicExtraBold(size: 25)
            $0.textAlignment = .left
        }
        
        let genderSegmentedControl = createSegmentedControl(first: "Male", second: "Female")
        
        
        lazy var segmentedControlContainerView = UIView().then {
            $0.addSubview(genderSegmentedControl)
            
            $0.backgroundColor = .clear
        }
        
        lazy var genderStackView = UIStackView().then {
            $0.addArrangedSubview(genderLabel)
            $0.addArrangedSubview(genderSegmentedControl)
            
            $0.axis = .vertical
            $0.distribution = .fill
            $0.alignment = .leading
            $0.spacing = 5
        }
        
        self.view.addSubview(genderStackView)
        
        genderSegmentedControl.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.right.equalToSuperview()
        }
        
        genderStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.left.right.equalToSuperview().inset(16)
        }
        
        return genderStackView
    }
    
    /// Create Age Stack View
    /// - Returns: UIStackView object
    private func createAgeStackView() -> UIStackView {
        lazy var ageLabel = UILabel().then {
            $0.text = "Age"
            $0.font = UIFont.returnNanumGothicExtraBold(size: 25)
            $0.textAlignment = .left
        }
        
        let ageSegmentedControl = createSegmentedControl(first: "~25",
                                                         second: "26 ~ 32",
                                                         third: "33 ~ 40",
                                                         fourth: "41 ~")
        
        
        lazy var segmentedControlContainerView = UIView().then {
            $0.addSubview(ageSegmentedControl)
            
            $0.backgroundColor = .clear
        }
        
        lazy var ageStackView = UIStackView().then {
            $0.addArrangedSubview(ageLabel)
            $0.addArrangedSubview(ageSegmentedControl)
            
            $0.axis = .vertical
            $0.distribution = .fill
            $0.alignment = .leading
            $0.spacing = 5
        }
        
        self.view.addSubview(ageStackView)
        
        ageSegmentedControl.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.right.equalToSuperview()
        }
        
        ageStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.left.right.equalToSuperview().inset(16)
        }
        
        return ageStackView
    }
    
    /// Create Activity Stack View
    /// - Returns: UIStackView object
    private func createActivityStackView() -> UIStackView {
        lazy var caategoryLabel = UILabel().then {
            $0.text = "Activity Category"
            $0.font = UIFont.returnNanumGothicExtraBold(size: 25)
            $0.textAlignment = .left
        }
        
        let activitySegmentedControl = createSegmentedControl(first: "I prefer outdoor activity",
                                                              second: "I prefer indoor activity")
        
        lazy var segmentedControlContainerView = UIView().then {
            $0.addSubview(activitySegmentedControl)
            
            $0.backgroundColor = .clear
        }
        
        lazy var activityStackView = UIStackView().then {
            $0.addArrangedSubview(caategoryLabel)
            $0.addArrangedSubview(activitySegmentedControl)
            
            $0.axis = .vertical
            $0.distribution = .fill
            $0.alignment = .leading
            $0.spacing = 5
        }
        
        self.view.addSubview(activityStackView)
        
        activitySegmentedControl.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.right.equalToSuperview()
        }
        
        activityStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.left.right.equalToSuperview().inset(16)
        }
        
        return activityStackView
    }
    
    /// Create Time Stack View
    /// - Returns: UIStackView object
    private func createTimeStackView() -> UIStackView {
        lazy var timeLabel = UILabel().then {
            $0.text = "Activity Time"
            $0.font = UIFont.returnNanumGothicExtraBold(size: 25)
            $0.textAlignment = .left
        }
        
        let timeSegmentedControl = createSegmentedControl(first: "Morning",
                                                          second: "Afternoon",
                                                          third: "Evening")
        
        lazy var segmentedControlContainerView = UIView().then {
            $0.addSubview(timeSegmentedControl)
            
            $0.backgroundColor = .clear
        }
        
        lazy var timeStackView = UIStackView().then {
            $0.addArrangedSubview(timeLabel)
            $0.addArrangedSubview(timeSegmentedControl)
            
            $0.axis = .vertical
            $0.distribution = .fill
            $0.alignment = .leading
            $0.spacing = 5
        }
        
        self.view.addSubview(timeStackView)
        
        timeSegmentedControl.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.right.equalToSuperview()
        }
        
        timeStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.left.right.equalToSuperview().inset(16)
        }
        
        return timeStackView
    }
    
    /// Create Sensitivity Stack View
    /// - Returns: UIStackView object
    private func createSentivityStackView() -> UIStackView {
        lazy var sentivitityLabel = UILabel().then {
            $0.text = "Temperature-Sensitivity"
            $0.font = UIFont.returnNanumGothicExtraBold(size: 25)
            $0.textAlignment = .left
        }
        
        let sensitivitySegmentedControl = createSegmentedControl(first: "Sensitive to heat",
                                                                 second: "Normal",
                                                                 third: "Sensitive to cold")
        
        
        lazy var segmentedControlContainerView = UIView().then {
            $0.addSubview(sensitivitySegmentedControl)
            
            $0.backgroundColor = .clear
        }
        
        lazy var sensitivityStackView = UIStackView().then {
            $0.addArrangedSubview(sentivitityLabel)
            $0.addArrangedSubview(sensitivitySegmentedControl)
            
            $0.axis = .vertical
            $0.distribution = .fill
            $0.alignment = .leading
            $0.spacing = 5
        }
        
        self.view.addSubview(sensitivityStackView)
        
        sensitivitySegmentedControl.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.right.equalToSuperview()
        }
        
        sensitivityStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.left.right.equalToSuperview().inset(16)
        }
        
        return sensitivityStackView
    }
    
    /// Create Style Stack View
    /// - Returns: UIStackView object
    private func createStyleStackView() -> UIStackView {
        lazy var sentivitityLabel = UILabel().then {
            $0.text = "Preference Style"
            $0.font = UIFont.returnNanumGothicExtraBold(size: 25)
            $0.textAlignment = .left
        }
        
        let stylePickerView = createStylePickerView()
        
        lazy var styleStackView = UIStackView().then {
            $0.addArrangedSubview(sentivitityLabel)
            $0.addArrangedSubview(stylePickerView)
            
            $0.axis = .vertical
            $0.distribution = .fill
            $0.alignment = .leading
            $0.spacing = 5
        }
        
        self.view.addSubview(styleStackView)
        
        stylePickerView.snp.makeConstraints {
            $0.height.equalTo(200)
            $0.right.equalToSuperview()
        }
        
        styleStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.left.right.equalToSuperview().inset(16)
        }
        
        return styleStackView
    }
    
    /// Create SegmentedControl
    /// - Returns: UISegmentedControl object
    private func createSegmentedControl(first: String,
                                        second: String,
                                        third: String? = nil,
                                        fourth: String? = nil) -> UISegmentedControl {
        var containerSegmentedControl = UISegmentedControl()
        if let third = third {
            containerSegmentedControl = UISegmentedControl(items: [first, second, third])
            if let fourth = fourth {
                containerSegmentedControl = UISegmentedControl(items: [first, second, third, fourth])
            }
        } else {
            containerSegmentedControl = UISegmentedControl(items: [first, second])
        }
        
        
        containerSegmentedControl.selectedSegmentIndex = 0
        containerSegmentedControl.layer.cornerRadius = 4
        containerSegmentedControl.backgroundColor = .systemGray
        containerSegmentedControl.tintColor = .yellow
        
        return containerSegmentedControl
    }
    
    private func createStylePickerView() -> UIPickerView {
        var pickerView = UIPickerView()
        
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.layer.cornerRadius = 4
        pickerView.backgroundColor = .systemGray
        pickerView.tintColor = .yellow
        
        return pickerView
    }
    
    @objc
    private func segmentedValueChanged(_ sender: UISegmentedControl!) {
        print(#fileID, #function, #line, "- <#Comment#> Selected Segment Index is : \(sender.selectedSegmentIndex)")
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dummyManStyleData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dummyManStyleData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("select=\(row)")
    }
}



#if DEBUG

import SwiftUI

struct SettingViewControllerPresentable: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        SettingViewController()
    }
}


struct SettingViewControllerPresentable_PreviewProvider: PreviewProvider {
    static var previews: some View {
        SettingViewControllerPresentable()
            .previewDevice("iPhone 12")
            .ignoresSafeArea()
    }
}

#endif
