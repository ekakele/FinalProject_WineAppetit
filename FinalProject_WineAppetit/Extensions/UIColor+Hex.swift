//
//  UIColor+Hex.swift
//  FinalProject_WineAppetit
//
//  Created by Eka Kelenjeridze on 25.01.24.
//

import UIKit

extension UIColor {
    convenience init(hex: String) {
        let cleanedHex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var hexNumber: UInt64 = 0
        
        let scanner = Scanner(string: cleanedHex)
        if scanner.scanHexInt64(&hexNumber) {
            let red = CGFloat((hexNumber & 0xFF0000) >> 16) / 255.0
            let green = CGFloat((hexNumber & 0x00FF00) >> 8) / 255.0
            let blue = CGFloat(hexNumber & 0x0000FF) / 255.0
            
            self.init(red: red, green: green, blue: blue, alpha: 1.0)
        } else {
            self.init(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
}
