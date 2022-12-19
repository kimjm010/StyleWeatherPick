//
//  MainViewController.swift
//  StyleWeatherPick
//
//  Created by Chris Kim on 12/18/22.
//

import UIKit

class MainViewController: UIViewController {
    // MARK: - Vars
    private var addressLabel = ""
    private var currentTemp = -1.0
    private var descriptionLabel = ""
    private var maxTemp = 2
    private var minTemp = -9.0
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
    }
}
