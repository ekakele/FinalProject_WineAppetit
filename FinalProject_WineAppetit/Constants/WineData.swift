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

// MARK: - Enums
enum WineType: String, CaseIterable {
    case red = "Red"
    case white = "White"
    case rose = "Rose"
}

enum WineCategory: String, CaseIterable {
    case dry = "Dry"
    case semiDry = "Semi-Dry"
    case sweet = "Sweet"
    case semiSweet = "Semi-Sweet"
    case fortified = "Fortified"
    case sparkling = "Sparkling"
}

// MARK: - Extension
extension WineType {
    var backgroundColors: [CGColor] {
        switch self {
        case .red:
            return Constants.AppColor.redForGradient
        case .white:
            return Constants.AppColor.whiteForGradient
        case .rose:
            return Constants.AppColor.roseForBackground
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
        CalorieInfo(category: .dry, calories: 120),
        CalorieInfo(category: .semiDry, calories: 120),
        CalorieInfo(category: .sweet, calories: 175),
        CalorieInfo(category: .semiSweet, calories: 130),
        CalorieInfo(category: .fortified, calories: 190),
        CalorieInfo(category: .sparkling, calories: 100),
    ],
    .white: [
        CalorieInfo(category: .dry, calories: 120),
        CalorieInfo(category: .semiDry, calories: 120),
        CalorieInfo(category: .sweet, calories: 175),
        CalorieInfo(category: .semiSweet, calories: 130),
        CalorieInfo(category: .fortified, calories: 190),
        CalorieInfo(category: .sparkling, calories: 100),
    ],
    .rose: [
        CalorieInfo(category: .dry, calories: 120),
        CalorieInfo(category: .semiDry, calories: 120),
        CalorieInfo(category: .sweet, calories: 175),
        CalorieInfo(category: .semiSweet, calories: 130),
        CalorieInfo(category: .fortified, calories: 190),
        CalorieInfo(category: .sparkling, calories: 100),
    ]
]
