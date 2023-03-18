//
//  Date+Formatter.swift
//  StyleWeatherPick
//
//  Created by Chris Kim on 2023/03/18.
//

import Foundation


fileprivate let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "ko_kr")
    
    return formatter
}()


extension Date {
    var dateToString: String {
        dateFormatter.dateFormat = "M월 d일(E)"
        return dateFormatter.string(from: self)
    }
    
    var timeToString: String {
        dateFormatter.dateFormat = "HH:00"
        return dateFormatter.string(from: self)
    }
}
