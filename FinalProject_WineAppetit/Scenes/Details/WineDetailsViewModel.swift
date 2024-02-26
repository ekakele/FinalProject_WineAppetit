//
//  WineDetailsViewModel.swift
//  FinalProject_WineAppetit
//
//  Created by Eka Kelenjeridze on 27.01.24.
//

import UIKit
import GenericNetworkManager

protocol WineDetailsViewModelDelegate: AnyObject {
    func wineDetailsFetched(_ wine: WineDetails)
    func wineImageFetched(_ image: UIImage)
    func wineCheckedInFavorites(_ isFavorited: Bool)
    func showError(_ error: Error)
}

protocol WineDetailsViewModel {
    var delegate: WineDetailsViewModelDelegate? { get set }
    func viewDidLoad()
    func toggleFavoriteStatus()
}

final class DefaultWineDetailsViewModel: WineDetailsViewModel {
    // MARK: - Properties
    private var wineID: Int
    private var isBarcode: Bool = false
    weak var delegate: WineDetailsViewModelDelegate?
    private let baseURL = Constants.API.wineApiBaseURL
    private let APIKey = Constants.API.wineApiKey
    
    // MARK: - Init
    init(wineID: Int) {
        self.wineID = wineID
    }
    
    // MARK: - ViewLifeCycle
    func viewDidLoad() {
        fetchWineDetails()
        checkIsWineFavorited()
    }
    
    // MARK: - Methods
    func toggleFavoriteStatus() {
        let isFavorited = UserPreferencesManager.shared.checkIsWineFavorited(forKey: wineID)
        UserPreferencesManager.shared.saveWineInFavorites(forKey: wineID, value: !isFavorited)
        delegate?.wineCheckedInFavorites(!isFavorited)
    }
    
    // MARK: - Private Methods
    private func fetchWineDetails() {
        let endpoint = "api/wines/"
        let idString = String(wineID)
        let APIKeyString = "?apiKey=\(APIKey)"
        let urlString = baseURL + endpoint + (isBarcode ? "barcode/\(idString)" : idString) + APIKeyString
        
        GenericNetworkManager.shared.fetchData(with: urlString) { [weak self] (result: Result<WineDetailsData, Error>) in
            switch result {
            case .success(let wine):
                self?.wineID = wine.details.id
                self?.delegate?.wineDetailsFetched(wine.details)
                self?.loadImage(from: wine.details.image ?? "")
            case .failure(let error):
                self?.delegate?.showError(error)
            }
        }
    }
    
    private func loadImage(from urlString: String) {
        Task {
            do {
                let image = try await ImageLoader.shared.fetchAndCacheImage(with: urlString)
                DispatchQueue.main.async {
                    self.delegate?.wineImageFetched(image ?? UIImage(named: "noImage") ?? UIImage())
                }
            } catch {
                self.delegate?.showError(error)
            }
        }
    }
    
    private func checkIsWineFavorited() {
        let isFavorited = UserPreferencesManager.shared.checkIsWineFavorited(forKey: wineID)
        self.delegate?.wineCheckedInFavorites(isFavorited)
    }
}
