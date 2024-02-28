//
//  UserPreferencesManager.swift
//  FinalProject_WineAppetit
//
//  Created by Eka Kelenjeridze on 25.01.24.
//

import Foundation

final class UserPreferencesManager {
    // MARK: - Properties
    static let shared = UserPreferencesManager()
    private let defaults = UserDefaults.standard
    
    private let favoritedWineListKey = "favoriteWines"
    private let onboardingPassStatusKey = "isOnboardingPassed"
    
    // MARK: - OnboardingPassStatus Set/Get Methods
    func getOnboardingPassStatus() -> Bool {
        return defaults.bool(forKey: onboardingPassStatusKey)
    }
    
    func saveOnboardingPassStatus(value isPassed: Bool) {
        defaults.set(isPassed, forKey: onboardingPassStatusKey)
    }
    
    // MARK: - FavoritedWineList Set/Get Methods
    func getFavoriteWineList() -> [Int] {
        if let favorites = defaults.array(forKey: favoritedWineListKey) as? [Int] {
            return favorites
        } else {
            return []
        }
    }
    
    func checkIsWineFavorited(forKey wineID: Int) -> Bool {
        return getFavoriteWineList().contains(wineID)
    }
    
    func saveWineInFavorites(forKey wineID: Int, value: Bool) {
        var favorites = getFavoriteWineList()
        if value {
            if !favorites.contains(wineID) {
                favorites.append(wineID)
            }
        } else {
            favorites.removeAll { $0 == wineID }
        }
        defaults.set(favorites, forKey: favoritedWineListKey)
    }
}
