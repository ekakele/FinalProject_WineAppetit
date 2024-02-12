//
//  CustomSearchController.swift
//  FinalProject_WineAppetit
//
//  Created by Eka Kelenjeridze on 23.01.24.
//

import UIKit

protocol CustomSearchControllerDelegate: AnyObject {
    func searchBarDidSearch(with text: String)
    func searchBarDidCancel()
}

final class CustomSearchController: UISearchController {
    // MARK: - Properties
    weak var searchControllerDelegate: CustomSearchControllerDelegate?
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
    }
    
    // MARK: - Inits
    init(placeholder: String? = "Search") {
        super.init(nibName: nil, bundle: nil)
        setupSearchBar(placeholder: placeholder)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Private Methods
    private func setupSearchBar(placeholder: String? = "Search") {
        navigationItem.searchController = self
        searchResultsUpdater = self
        
        searchBar.placeholder = placeholder
        definesPresentationContext = true
        
        searchBar.delegate = self
    }
}

// MARK: - UISearchResultsUpdating
extension CustomSearchController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text, !searchText.isEmpty else {
            return
        }
        searchControllerDelegate?.searchBarDidSearch(with: searchText)
    }
}

// MARK: - UISearchBarDelegate
extension CustomSearchController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchControllerDelegate?.searchBarDidCancel()
    }
}
