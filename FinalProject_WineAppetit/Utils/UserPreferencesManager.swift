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
    let defaults = UserDefaults.standard
    private let favoritedWineListKey = "favoriteWines"
    
    // MARK: - Methods
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
    
    func checkIsWineFavorited(forKey wineID: Int) -> Bool {
        return getFavoriteWineList().contains(wineID)
    }
    
    func getFavoriteWineList() -> [Int] {
        if let favorites = defaults.array(forKey: favoritedWineListKey) as? [Int] {
            return favorites
        } else {
            return []
        }
    }
}
