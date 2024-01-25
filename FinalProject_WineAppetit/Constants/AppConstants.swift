//
//  AppConstants.swift
//  FinalProject_WineAppetit
//
//  Created by Eka Kelenjeridze on 23.01.24.
//

import UIKit

struct Constants {
    
    struct API {
        static let wineApiBaseURL = "https://api.openwine.space/"
        static let wineApiEndpoint = "api/wines?page=1"
        static let wineApiKey = "" //TODO: - add key to API
    }
    
    struct AppDefaultImage {
        static let wineImage = UIImage(named: "testWine")
        static let noImage = UIImage(named: "noImage")
    }
    
    struct AppFont {
        static let primaryTitle = UIFont.systemFont(ofSize: 24, weight: .bold)
        static let primaryInfo = UIFont.systemFont(ofSize: 20, weight: .regular)
        static let primaryIconText = UIFont.systemFont(ofSize: 16, weight: .light)
       
        static let secondaryTitle = UIFont.systemFont(ofSize: 14, weight: .bold)
        static let secondaryInfo = UIFont.systemFont(ofSize: 12, weight: .regular)
        static let secondaryIconText = UIFont.systemFont(ofSize: 14, weight: .light)
        static let secondaryTag = UIFont.systemFont(ofSize: 10, weight: .regular)
    }

    struct AppColor {
        static let categoryText = UIColor(hex: "#8B112E")
        static let shadeBackground = UIColor(hex: "#FF003D").withAlphaComponent(0.06).cgColor
        static let tagBackground = UIColor(hex: "#edede9")
        static let redFill = UIColor(hex: "#c0070b")
        static let grayStroke = UIColor(hex: "#7f7f7f")
    }
}
