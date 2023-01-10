//
//  Styles.swift
//  StyleWeatherPick
//
//  Created by Chris Kim on 12/20/22.
//

import Foundation

enum Styles {
    enum MenStyles: String {
        case Street
        case Hiphop
        case Casual
        case Dandy
        case Classic
        case Minimalism
    }
    
    enum WomenStyles: String {
        case Street
        case Hiphop
        case Casual
        case BusinessCasual
        case Feminime
        case Minimalism
    }
}


#warning("Todo: - Dummy 데이터 생성하기")
struct StyleWeather: Codable {
    let styleName: String
    let styleImageName: String
}


enum Gender: String {
    case male
    case female
}


enum ManStyle: String {
    case Street = "Street / Hiphop"
    case Casual
    case Minimalism
    case Dandy
    case BusinessCasual
    case Classic
}

let dummyManStyleData = [
    "Street",
    "Causal",
    "Minimalsim",
    "Business Casual",
    "Dandy",
    "Classic"
]

enum WomanStyle: String {
    case Street = "Street / Hiphop"
    case Casual
    case Minimalism
    case Business = "Business Casual"
    case Feminine
}

let dummyWomanStyleData = [
    "Street",
    "Casual",
    "Minimalism",
    "Business Casual",
    "Feminine"
]
