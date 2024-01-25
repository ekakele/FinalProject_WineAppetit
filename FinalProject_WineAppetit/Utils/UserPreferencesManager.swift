//
//  UserPreferencesManager.swift
//  FinalProject_WineAppetit
//
//  Created by Eka Kelenjeridze on 25.01.24.
//

import Foundation

final class UserPreferencesManager {
    //MARK: - Properties
    static let shared = UserPreferencesManager()
    let defaults = UserDefaults.standard
    
    //MARK: - Methods
    func saveWineInFavorites(forKey wineID: Int, value: Bool) {
        defaults.set(value, forKey: String(wineID))
    }
    
    func checkIsWineFavorited(forKey wineID: Int) -> Bool {
        if let isFaved = defaults.object(forKey: String(wineID)) as? Bool {
            return isFaved
        } else {
            return false
        }
    }
}
