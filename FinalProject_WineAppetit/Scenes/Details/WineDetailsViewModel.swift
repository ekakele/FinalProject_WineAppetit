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
    func showError(_ error: Error)
    func wineImageFetched(_ image: UIImage)
}

protocol WineDetailsViewModel {
    var delegate: WineDetailsViewModelDelegate? { get set }
    func viewDidLoad()
}

final class DefaultWineDetailsViewModel: WineDetailsViewModel {
    // MARK: - Properties
    private var wineID: Int
    weak var delegate: WineDetailsViewModelDelegate?
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
    private func fetchWineDetails() {
        let endpoint = "api/wines/"
        let idString = String(wineID)
        let urlString = baseURL + endpoint + idString
        
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
