//
//  Wine.swift
//  FinalProject_WineAppetit
//
//  Created by Eka Kelenjeridze on 23.01.24.
//

import Foundation

// MARK: - WineData
struct WineData: Decodable {
    let result: [Wine]
    
    enum CodingKeys: String, CodingKey {
        case result = "data"
    }
}

// MARK: - Datum
struct Wine: Decodable {
    let id: Int
    let barcode: String
    let title: String
    let description: String
    let price: String
    let image: String?
    let categoriesList: [String]
    let vintageYear: String?
    let color: String?
    let grape: String?
    let brand: String?
    let region: String?
    let technology: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case barcode
        case title = "product"
        case description
        case price
        case image
        case categoriesList = "categories_list"
        case vintageYear = "year"
        case color
        case grape
        case brand
        case region
        case technology
    }
}
