//
//  WineData.swift
//  FinalProject_WineAppetit
//
//  Created by Eka Kelenjeridze on 29.01.24.
//

import UIKit

// MARK: - Protocols
protocol WineCalories {
    var description: String { get }
    var calories: Int { get }
}

protocol DropdownOption: CaseIterable, RawRepresentable where RawValue == String {}

// MARK: - Enums
enum WineType: String, DropdownOption {
    case red = "Red"
    case white = "White"
    case rose = "Rose"
}

enum WineCategory: String, DropdownOption {
    case dry = "Dry"
    case semiDry = "Semi-Dry"
    case sweet = "Sweet"
    case semiSweet = "Semi-Sweet"
    case fortified = "Fortified"
    case sparkling = "Sparkling"
}

enum WineTechnology: String, DropdownOption {
    case classic = "Classic"
    case petnat = "Petnat"
    case qvevri = "Qvevri"
    case sparkling = "Sparkling"
}

enum WineRegion: String, DropdownOption {
    case adjara = "Adjara"
    case imereti = "Imereti"
    case kakheti = "Kakheti"
    case kartli = "Kartli"
    case lechkhumi = "Lechkhumi"
    case racha = "Racha"
    case samegrelo = "Samegrelo"
    case guria = "Guria"
}

// MARK: - Extension
extension WineType {
    var backgroundColors: [CGColor] {
        switch self {
        case .red:
            return Constants.AppUIColor.redForGradient
        case .white:
            return Constants.AppUIColor.whiteForGradient
        case .rose:
            return Constants.AppUIColor.roseForBackground
        }
    }
}

// MARK: - Struct
struct CalorieInfo: WineCalories {
    var category: WineCategory
    var calories: Int
    var description: String {
        return category.rawValue
    }
}

// MARK: - WineCalories Data
let wineCalories: [WineType: [CalorieInfo]] = [
    .red: [
        CalorieInfo(category: .dry, calories: 153),
        CalorieInfo(category: .semiDry, calories: 120),
        CalorieInfo(category: .sweet, calories: 213),
        CalorieInfo(category: .semiSweet, calories: 177),
        CalorieInfo(category: .fortified, calories: 217),
        CalorieInfo(category: .sparkling, calories: 158),
    ],
    .white: [
        CalorieInfo(category: .dry, calories: 135),
        CalorieInfo(category: .semiDry, calories: 153),
        CalorieInfo(category: .sweet, calories: 195),
        CalorieInfo(category: .semiSweet, calories: 165),
        CalorieInfo(category: .fortified, calories: 232),
        CalorieInfo(category: .sparkling, calories: 163),
    ],
    .rose: [
        CalorieInfo(category: .dry, calories: 102),
        CalorieInfo(category: .semiDry, calories: 114),
        CalorieInfo(category: .sweet, calories: 138),
        CalorieInfo(category: .semiSweet, calories: 122),
        CalorieInfo(category: .fortified, calories: 159),
        CalorieInfo(category: .sparkling, calories: 123),
    ]
]
