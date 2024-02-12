import Foundation
import GenericNetworkManager

protocol WineRandomizerViewModelDelegate: AnyObject {
    func didFetchWines(_ wines: [Wine])
    func didFailWithError(_ error: Error)
    func navigateToWineDetails(with wineID: Int)
}

final class WineRandomizerViewModel {
    // MARK: - Properties
    private var wines: [Wine]?
    weak var delegate: WineRandomizerViewModelDelegate?
    private let baseURL = Constants.API.wineApiBaseURL
    private let APIKey = Constants.API.wineApiKey
    
    // MARK: - ViewLifeCycle
    func viewDidLoad() {
        filterWines()
    }
    
    // MARK: - Methods
    func didSelectWine(at indexPath: IndexPath) {
        if let wineID = wines?[indexPath.row].id {
            delegate?.navigateToWineDetails(with: wineID)
        }
    }
    
    func filterWines(with category: String? = nil, subCategory: String? = nil, technology: String? = nil, region: String? = nil) {
        fetchWines(with: category, subCategory, technology, region)
    }
    
    // MARK: - Private Methods
    private func fetchWines(with category: String?, _ subCategory: String?, _ technology: String?, _ region: String?) {
        let endpoint = "api/wines?apiKey=\(APIKey)"
        var queryString = ""
        
        queryString += addParameter(parameterName: "category", category)
        queryString += addParameter(parameterName: "subCategory", subCategory)
        queryString += addParameter(parameterName: "technology", technology)
        queryString += addParameter(parameterName: "region", region)
        
        let urlString = baseURL + endpoint + queryString
        
        GenericNetworkManager.shared.fetchData(with: urlString) { [weak self] (result: Result<WineData, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let wineData):
                    self?.wines = wineData.result
                    self?.delegate?.didFetchWines(wineData.result)
                case .failure(let error):
                    self?.delegate?.didFailWithError(error)
                }
            }
        }
    }
    
    private func addParameter(parameterName: String, _ value: String?) -> String {
        guard let value = value, !value.isEmpty else { return "" }
        return "&\(parameterName)=\(value)"
    }
}
