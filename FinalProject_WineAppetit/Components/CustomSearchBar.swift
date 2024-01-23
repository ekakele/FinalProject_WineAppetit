//
//  CustomSearchBarViewController.swift
//  FinalProject_WineAppetit
//
//  Created by Eka Kelenjeridze on 23.01.24.
//

import UIKit

protocol SearchBarDelegate: AnyObject {
    func searchBarDidSearch(with text: String)
}

final class CustomSearchBar: UISearchController, UISearchResultsUpdating {
    //MARK: - Properties
    weak var searchBarDelegate: SearchBarDelegate?
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
    }
    
    //MARK: - Inits
    init(placeholder: String? = "Search") {
        super.init(nibName: nil, bundle: nil)
        setupSearchBar(placeholder: placeholder)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //MARK: - Private Methods
    private func setupSearchBar(placeholder: String? = "Search") {
        navigationItem.searchController = self
        searchResultsUpdater = self
        
        searchBar.placeholder = placeholder
        definesPresentationContext = true
    }
    
    //MARK: - Methods
    func updateSearchResults(for searchController: UISearchController) {
        searchBarDelegate?.searchBarDidSearch(with: searchController.searchBar.text ?? "")
        guard let text = searchController.searchBar.text, !text.isEmpty else {
            return
        }
    }
}
