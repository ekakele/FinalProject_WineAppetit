//
//  MyWineLibraryViewModel.swift
//  FinalProject_WineAppetit
//
//  Created by Eka Kelenjeridze on 31.01.24.
//

import Foundation
import GenericNetworkManager

final class MyWineLibraryViewModel: ObservableObject {
    // MARK: - Init
    @Published var wines: [Wine] = []
    private let baseURL = Constants.API.wineApiBaseURL
    
    // MARK: - Init
    init() {
        fetchWines()
    }
    
    // MARK: - Methods
    func filteredWines(category: String) -> [Wine] {
        let category = category.uppercased()
        let filteredWines = wines.filter { $0.categoriesList[0] == category }
        return filteredWines
    }
    
    // MARK: - Private Methods
    private func fetchWines() {
        let endpoint = "api/wines?page=1"
        let favoriteWineIDList = UserPreferencesManager.shared.getFavoriteWineList().map { String($0) }.joined(separator: ",")
        let queryString = "&ids=" + favoriteWineIDList
        
        let urlString = baseURL + endpoint + queryString
        print(urlString)
        
        GenericNetworkManager.shared.fetchData(with: urlString) { [weak self] (result: Result<WineData, Error>) in
            switch result {
            case .success(let wines):
                self?.wines = wines.result
            case .failure(let error):
                print(error)
            }
        }
    }
}
