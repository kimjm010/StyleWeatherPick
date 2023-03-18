//
//  Double+Formatter.swift
//  StyleWeatherPick
//
//  Created by Chris Kim on 2023/03/18.
//

import Foundation


fileprivate let formatter: MeasurementFormatter = {
    let formatter = MeasurementFormatter()
    formatter.locale = Locale(identifier: "ko_kr")
    formatter.unitOptions = .temperatureWithoutUnit
    formatter.numberFormatter.maximumFractionDigits = 1
    
    return formatter
}()


extension Double {
    var temperatureString: String {
        let unit = Measurement<UnitTemperature>(value: self, unit: .celsius)
        return formatter.string(from: unit)
    }
}

