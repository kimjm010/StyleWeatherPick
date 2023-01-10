//
//  UIFont+Extension.swift
//  StyleWeatherPick
//
//  Created by Chris Kim on 1/10/23.
//

import UIKit

// UIFont Extension
extension UIFont {
    static func returnNanumGothic(size: CGFloat) -> UIFont {
        return UIFont(name: "NanumGothic", size: size)!
    }
    
    static func returnNanumGothicBold(size: CGFloat) -> UIFont {
        return UIFont(name: "NanumGothicBold", size: size)!
    }
    
    static func returnNanumGothicExtraBold(size: CGFloat) -> UIFont {
        return UIFont(name: "NanumGothicExtraBold", size: size)!
    }
}
