//
//  WeatherModel.swift
//  StyleWeatherPick
//
//  Created by Chris Kim on 2023/03/17.
//

import Foundation

struct WeatherSummary: Codable {
    struct Weather: Codable {
        let description: String
        let icon: String
    }
    
    let weather: [Weather]
    
    struct Main: Codable {
        let temp: Double
        let feels_like: Double
        let temp_min: Double
        let temp_max: Double
    }
    
    let main: Main
}


struct Forecast: Codable {
    struct ForecastItem: Codable {
        let dt: Int
        
        var date: Date {
            return Date(timeIntervalSince1970: Double(dt))
        }
        
        struct Main: Codable {
            let temp: Double
        }
        
        let main: Main
        
        struct Weather: Codable {
            let description: String
            let icon: String
        }
        
        let weather: [Weather]
    }
    
    let list: [ForecastItem]
}
