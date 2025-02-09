//
//  UIColor+.swift
//  MovieLike
//
//  Created by 최정안 on 1/26/25.
//

import UIKit

func hexColor(hex: String) -> UIColor {
    let int = Int(hex, radix: 16)!
    
    let red = CGFloat((int >> 16) & 0xFF) / 255.0
    let green = CGFloat((int >> 8) & 0xFF) / 255.0
    let blue = CGFloat(int & 0xFF) / 255.0
    
    return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
}

extension UIColor {
    static let ValidButtonColor = hexColor(hex: "186FF2")
    static let InvalidButtonColor = hexColor(hex: "8C8C8C")
    static let ValidLabelColor = hexColor(hex: "186FF2")
    static let InvalidLabelColor = hexColor(hex: "F04452")
}
