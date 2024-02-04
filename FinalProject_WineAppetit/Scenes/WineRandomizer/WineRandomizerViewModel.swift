////
////  WineRandomizerViewModel.swift
////  FinalProject_WineAppetit
////
////  Created by Eka Kelenjeridze on 05.02.24.
////
//
//import Foundation
//
//final class WineRandomizerViewModel {
//
//    // MARK: - Methods
//    func spinSlots() {
//        let maxRow = max(wines.count - 1, 0)
//        let randomRow = Int.random(in: 0...maxRow)
//        winePickerView.selectRow(randomRow, inComponent: 0, animated: true)
//        
//        if maxRow >= 0 {
//            let selectedWine = wines[randomRow]
//            titleLabel.text = selectedWine.title
//            brandLabel.text = selectedWine.brand
//        }
//    }
//}
