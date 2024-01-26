//
//  WineDetailsViewModel.swift
//  FinalProject_WineAppetit
//
//  Created by Eka Kelenjeridze on 27.01.24.
//

import UIKit
import GenericNetworkManager

protocol DetailsViewModelDelegate: AnyObject {
    func wineDetailsFetched(_ wine: Wine)
    func showError(_ error: Error)
    func wineImageFetched(_ image: UIImage)
}

final class MovieDetailsViewModel {
    // MARK: - Properties
    private var wineID: Int
    weak var delegate: DetailsViewModelDelegate?
    private let baseURL = Constants.API.wineApiBaseURL
    
    // MARK: - Init
    init(wineID: Int) {
        self.wineID = wineID
    }
    
    // MARK: - ViewLifeCycle
    func viewDidLoad() {
        fetchWineDetails()
    }
    
    // MARK: - Private Methods
    private func fetchWineDetails(with query: String? = nil) {
        let endpoint = "api/wines?page=1" //TODO: - update
        var queryString = ""
        if let query = query, !query.isEmpty {
            queryString = "&q=\(query)"
        }
        let urlString = baseURL + endpoint + queryString
        
        GenericNetworkManager.shared.fetchData(with: urlString) { [weak self] (result: Result<Wine, Error>) in
            switch result {
            case .success(let wine):
                self?.wineID = wine.id
                self?.delegate?.wineDetailsFetched(wine)
            case .failure(let error):
                self?.delegate?.showError(error)
            }
        }
    }
    
    private func loadImage(from urlString: String) {
        Task {
            do {
                let image = try await ImageLoader.shared.fetchImage(with: urlString)
                DispatchQueue.main.async {
                    self.delegate?.wineImageFetched(image ?? UIImage(named: "noImage") ?? UIImage())
                }
            } catch {
                self.delegate?.showError(error)
                print("Error loading image: \(error)")
            }
        }
    }
}
