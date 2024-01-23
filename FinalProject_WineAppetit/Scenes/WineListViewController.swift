//
//  ViewController.swift
//  FinalProject_WineAppetit
//
//  Created by Eka Kelenjeridze on 22.01.24.
//

import UIKit

class WineListViewController: UIViewController {
    //MARK: - Properties
    private let wineCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private let searchBar = CustomSearchBar(placeholder: "Search for a wine")
    private var wines = [Wine]()
    private let viewModel = WineListViewModel()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBar()
        setupViewModel()
        setupUI()
    }
    
    //MARK: - Private Methods
    private func setupSearchBar() {
        searchBar.searchBarDelegate = self
        navigationItem.searchController = searchBar
    }
    
    private func setupViewModel() {
        viewModel.delegate = self
        viewModel.viewDidLoad()
    }
    
    private func setupUI() {
        setupBackground()
        addSubviews()
        setupWineCollectionView()
        setupWineCollectionViewConstraints()
    }
    
    private func setupBackground() {
        view.backgroundColor = .systemBackground
    }
    
    private func addSubviews() {
        view.addSubview(wineCollectionView)
    }
    
    private func setupWineCollectionView() {
        wineCollectionView.dataSource = self
        wineCollectionView.delegate = self
        
        wineCollectionView.register(
            WineItemCollectionViewCell.self,
            forCellWithReuseIdentifier: WineItemCollectionViewCell.identifier
        )
    }
    
    private func setupWineCollectionViewConstraints() {
        NSLayoutConstraint.activate([
            wineCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            wineCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            wineCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            wineCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

//MARK: - CollectionView DataSource
extension WineListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wines.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WineItemCollectionViewCell.identifier, for: indexPath) as? WineItemCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: wines[indexPath.row])
        return cell
    }
}

//MARK: - CollectionView Delegate
extension WineListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //TODO: - handle after adding VM
    }
}

//MARK: - CollectionView DelegateFlowLayout
extension WineListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = Int((view.frame.width - 48) / 2)
        let height = 180
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 32, right: 16)
    }
}

//MARK: - WineListViewModelDelegate
extension WineListViewController: WineListViewModelDelegate {
    func winesFetched(_ wines: [Wine]) {
        self.wines = wines
        DispatchQueue.main.async {
            self.wineCollectionView.reloadData()
        }
    }
    
    func showError(_ error: Error) {
        print("error")
    }
    
    func navigateToWineDetails(with id: String) {
        print("no navigation yet")
        //TODO: - handle after adding Details Page
    }
}

//MARK: - CustomSearchBar
extension WineListViewController: SearchBarDelegate {
    func searchBarDidSearch(with text: String) {
        //TODO: - ViewModel interaction for search
        print(text)
    }
}
