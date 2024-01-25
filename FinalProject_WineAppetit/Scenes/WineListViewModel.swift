//
//  WineListViewModel.swift
//  FinalProject_WineAppetit
//
//  Created by Eka Kelenjeridze on 23.01.24.
//

import Foundation
import GenericNetworkManager

protocol WineListViewModelDelegate: AnyObject {
    func winesFetched(_ wines: [Wine])
    func showError(_ error: Error)
    func navigateToWineDetails(with id: String)
}

final class WineListViewModel {
    // MARK: - Properties
    private var wines: [Wine]?
    weak var delegate: WineListViewModelDelegate?
    private let baseURL = "https://api.openwine.space/"
    
    // MARK: - ViewLifeCycle
    func viewDidLoad() {
        searchWines()
    }
    
    // MARK: - Methods
    func searchWines(with query: String? = nil) {
        fetchWines(with: query)
    }
    
    // MARK: - Private Methods
    private func fetchWines(with query: String?) {
        let endpoint = "api/wines?page=1"
        var queryString = ""
        if let query = query, !query.isEmpty {
            queryString = "&q=\(query)"
        }
        let urlString = baseURL + endpoint + queryString
        
        GenericNetworkManager.shared.fetchData(with: urlString) { [weak self] (result: Result<WineData, Error>) in
            switch result {
            case .success(let wines):
                self?.wines = wines.result
                self?.delegate?.winesFetched(wines.result)
            case .failure(let error):
                self?.delegate?.showError(error)
            }
        }
    }
}
