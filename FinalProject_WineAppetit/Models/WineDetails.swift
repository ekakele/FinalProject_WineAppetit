//
//  WineDetails.swift
//  FinalProject_WineAppetit
//
//  Created by Eka Kelenjeridze on 27.01.24.
//

import Foundation

// MARK: - WineData
struct WineDetailsData: Decodable {
    let details: WineDetails
    
    enum CodingKeys: String, CodingKey {
        case details = "data"
    }
}

// MARK: - Datum
struct WineDetails: Decodable {
    let id: Int
    let barcode: String
    let title: String
    let description: String?
    let price: String
    let image: String?
    let categoriesList: [String]
    let vintageYear: String?
    let color: String?
    let grape: String?
    let brand: String?
    let region: String?
    let technology: String?
    let volume: String?
    let alcohol: String?
    let aroma: [String]?
    let taste: [String]?
    
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
        case volume
        case alcohol
        case aroma
        case taste
    }
}
