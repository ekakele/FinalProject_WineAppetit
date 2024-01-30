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
        static let calorieCounterBackground = UIImage(named: "wineGlasses")
        
    }
    
    struct AppTextInfo {
        static let notApplicable = "N/A"
    }
    
    struct AppFont {
        static let primaryTitle = UIFont.systemFont(ofSize: 24, weight: .bold)
        static let primarySubtitle = UIFont.systemFont(ofSize: 18, weight: .bold)
        static let primaryInfo = UIFont.systemFont(ofSize: 20, weight: .regular)
        static let primarySubInfo = UIFont.systemFont(ofSize: 18, weight: .regular)
        static let primaryIconText = UIFont.systemFont(ofSize: 13, weight: .regular)
        
        static let secondaryTitle = UIFont.systemFont(ofSize: 14, weight: .bold)
        static let secondaryInfo = UIFont.systemFont(ofSize: 12, weight: .regular)
        static let secondaryIconText = UIFont.systemFont(ofSize: 14, weight: .light)
        static let secondaryTag = UIFont.systemFont(ofSize: 10, weight: .regular)
    }
    
    struct AppColor {
        static let labelText = UIColor.label
        static let categoryText = UIColor(hex: "#8B112E")
        
        static let shadeBackground = UIColor(hex: "#FF003D").withAlphaComponent(0.06).cgColor
        static let detailsBackground = UIColor(hex: "#FF003D").withAlphaComponent(0.1)
        static let buttonBackground = UIColor(hex: "#FF003D").withAlphaComponent(0.2)
        static let iconBackground = UIColor(hex: "#8B112E").withAlphaComponent(0.9)
        static let tagBackground = UIColor(hex: "#edede9")
        
        static let redFill = UIColor(hex: "#c0070b")
        static let grayStroke = UIColor(hex: "#7f7f7f")
        
        
        static let redWine = UIColor(hex: "#800020").cgColor
        static let whiteWine = UIColor(hex: "#FFBF00").cgColor
        static let roseWine = UIColor(hex: "#9B0047").cgColor
        static let white = UIColor(hex: "#F8EDEB").cgColor
        
        static let redForGradient: [CGColor] = [redWine, white]
        static let whiteForGradient: [CGColor] = [whiteWine, white]
        static let roseForBackground: [CGColor] = [roseWine,white]
    }
}
