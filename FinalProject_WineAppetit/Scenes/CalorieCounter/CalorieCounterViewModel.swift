//
//  CalorieCounterViewModel.swift
//  FinalProject_WineAppetit
//
//  Created by Eka Kelenjeridze on 29.01.24.
//

import Foundation

protocol CalorieCounterViewModelDelegate: AnyObject {
    func didUpdateGlassNumber(_ viewModel: CalorieCounterViewModel)
    func didUpdateWineSelection(_ viewModel: CalorieCounterViewModel)
}

final class CalorieCounterViewModel {
    // MARK: - Properties
    var glassNumber = 0
    var selectedWineTypeIndex = 0
    var selectedWineCategoryIndex = 0
    
    let wineTypes: [WineType] = [
        .red,
        .white,
        .rose
    ]
    
    let wineCategories: [WineCategory] = [
        .dry,
        .semiDry,
        .sweet,
        .semiSweet,
        .fortified,
        .sparkling
    ]
    
    weak var delegate: CalorieCounterViewModelDelegate?
    
    // MARK: - Methods
    func incrementGlassNumber() {
        glassNumber += 1
        delegate?.didUpdateGlassNumber(self)
    }
    
    func decrementGlassNumber() {
        if glassNumber > 0 {
            glassNumber -= 1
            delegate?.didUpdateGlassNumber(self)
        }
    }
    
    func resetGlassNumber() {
        glassNumber = 0
        delegate?.didUpdateGlassNumber(self)
    }
    
    func updateSelectedWineType(index: Int) {
        selectedWineTypeIndex = index
        delegate?.didUpdateWineSelection(self)
    }
    
    func updateSelectedWineCategory(index: Int) {
        selectedWineCategoryIndex = index
        delegate?.didUpdateWineSelection(self)
    }
    
    func selectedWineCalories() -> CalorieInfo? {
        let selectedWineType = wineTypes[selectedWineTypeIndex]
        return wineCalories[selectedWineType]?[selectedWineCategoryIndex]
    }
    
    func calculateTotalCalories() -> Int {
        guard let calorieInfo = selectedWineCalories() else { return 0 }
        return glassNumber * calorieInfo.calories
    }
}
