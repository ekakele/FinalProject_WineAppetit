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

// MARK: - Wine
struct Wine: Decodable {
    let id: Int
    let barcode: String
    let title: String
    let image: String?
    let categoriesList: [String]
    let vintageYear: String?
    let brand: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case barcode
        case title = "product"
        case image
        case categoriesList = "categories_list"
        case vintageYear = "year"
        case brand
    }
}
