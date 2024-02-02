//
//  WineItemCollectionViewCell.swift
//  FinalProject_WineAppetit
//
//  Created by Eka Kelenjeridze on 23.01.24.
//

import UIKit

final class WineItemCollectionViewCell: UICollectionViewCell {
    //MARK: - Properties
    static let identifier = "ItemCollectionViewCell"
    
    private lazy var cellStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [itemImageView, infoStackView])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 1
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var infoStackView = ShortInfoStackView(
        arrangedSubviews: [titleLabel, categoryStackView, brandLabel],
        stackAlignment: .center,
        stackSpacing: 0
    )
    
    private let titleLabel = CustomLabel(
        textColor: Constants.AppUIColor.labelText,
        font: Constants.AppUIFont.secondaryTitle,
        numberOfLines: 1
    )
    
    private lazy var categoryStackView = ShortInfoStackView(
        arrangedSubviews: [categoryLabel, subcategoryLabel],
        axis: .horizontal,
        distribution: .equalCentering,
        stackSpacing: 4
    )
    
    private let categoryLabel = CustomLabel(
        textColor: Constants.AppUIColor.categoryText,
        font: .systemFont(ofSize: 12, weight: .regular),
        numberOfLines: 1
    )
    
    private let subcategoryLabel = CustomLabel(
        textColor: Constants.AppUIColor.categoryText,
        font: .systemFont(ofSize: 12, weight: .regular),
        numberOfLines: 1
    )
    
    private let brandLabel = CustomLabel(
        textColor: Constants.AppUIColor.labelText,
        font: Constants.AppUIFont.secondaryInfo,
        numberOfLines: 1
    )
    
    private let vintageYearLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 14, y: 10, width: 36, height: 20)
        label.font = .systemFont(ofSize: 10, weight: .regular)
        label.textColor = Constants.AppUIColor.labelText
        label.textAlignment = .center
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.backgroundColor = Constants.AppUIColor.tagBackground
        return label
    }()
    
    private var addToFavoritesButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .gray
        button.frame = CGRect(x: 130, y: 10, width: 18, height: 16)
        return button
    }()
    
    private let shadeView: UIView = {
        let view = UIView()
        view.layer.backgroundColor = Constants.AppUIColor.shadeBackground
        view.layer.cornerRadius = 26
        view.widthAnchor.constraint(equalToConstant: 120).isActive = true
        view.heightAnchor.constraint(equalToConstant: 90).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let activityIndicator = ActivityIndicator()
    private var wine: Wine?
    
    //MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //MARK: - LifeCycle
    override func prepareForReuse() {
        super.prepareForReuse()
        
        activityIndicator.show()
        
        itemImageView.image = nil
        titleLabel.text = nil
        categoryLabel.text = nil
        subcategoryLabel.text = nil
        brandLabel.text = nil
        vintageYearLabel.text = nil
        addToFavoritesButton.tintColor = nil
    }
    
    //MARK: - Configure
    func configure(with wine: Wine) {
        self.wine = wine
        
        activityIndicator.show()
        
        displayImage(for: wine)
        titleLabel.text = wine.title
        categoryLabel.text = wine.categoriesList.first
        subcategoryLabel.text = wine.categoriesList[1]
        brandLabel.text = wine.brand
        displayVintageYear(wine.vintageYear)
        
        updateFavoriteButtonUI()
    }
    
    //MARK: - Private Methods
    private func setupUI() {
        setupActivityIndicator()
        addSubviews()
        setupShadeConstraints()
        setupImageConstraints()
        setupCellStackConstraints()
        setupButtonAction()
    }
    
    private func setupActivityIndicator() {
        activityIndicator.frame = contentView.bounds
        activityIndicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    private func addSubviews() {
        addSubview(activityIndicator)
        addSubview(cellStackView)
        
        cellStackView.addSubview(vintageYearLabel)
        cellStackView.addSubview(addToFavoritesButton)
        cellStackView.addSubview(shadeView)
        cellStackView.sendSubviewToBack(shadeView)
        
    }
    
    private func setupShadeConstraints() {
        NSLayoutConstraint.activate([
            shadeView.centerXAnchor.constraint(equalTo: cellStackView.centerXAnchor),
            shadeView.bottomAnchor.constraint(equalTo: itemImageView.bottomAnchor)
        ])
    }
    
    private func setupImageConstraints() {
        NSLayoutConstraint.activate([
            itemImageView.topAnchor.constraint(equalTo: cellStackView.topAnchor),
            itemImageView.leadingAnchor.constraint(equalTo: cellStackView.leadingAnchor),
            itemImageView.trailingAnchor.constraint(equalTo: cellStackView.trailingAnchor),
            itemImageView.bottomAnchor.constraint(equalTo: cellStackView.bottomAnchor, constant: -54)
        ])
    }
    
    private func setupCellStackConstraints() {
        NSLayoutConstraint.activate([
            cellStackView.topAnchor.constraint(equalTo: topAnchor),
            cellStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cellStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cellStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupButtonAction() {
        addToFavoritesButton.addAction(
            UIAction(handler: { [weak self] _ in
                self?.updateFavoriteButtonState()
            }),
            for: .touchUpInside
        )
    }
    
    private func updateFavoriteButtonState() {
        guard let wineID = wine?.id else { return }
        var isFaved = UserPreferencesManager.shared.checkIsWineFavorited(forKey: wineID)
        isFaved.toggle()
        UserPreferencesManager.shared.saveWineInFavorites(forKey: wineID, value: isFaved)
        updateFavoriteButtonUI()
    }
    
    private func updateFavoriteButtonUI() {
        guard let wineID = wine?.id else { return }
        let isFaved = UserPreferencesManager.shared.checkIsWineFavorited(forKey: wineID)
        let heartImage = UIImage(systemName: isFaved ? "heart.fill" : "heart")
        addToFavoritesButton.setImage(heartImage, for: .normal)
        addToFavoritesButton.tintColor = isFaved ? Constants.AppUIColor.redFill : Constants.AppUIColor.grayStroke
    }
    
    private func displayVintageYear(_ vintageYear: String?) {
        if let vintageYear = vintageYear, !vintageYear.isEmpty {
            vintageYearLabel.text = vintageYear
        } else {
            vintageYearLabel.isHidden = true
        }
    }
    
    private func displayImage(for wine: Wine) {
        if let imageURL = wine.image, !imageURL.isEmpty {
            loadAndCashImage(from: imageURL)
        } else {
            itemImageView.image = UIImage(named: "noImage")
        }
    }
    
    private func loadAndCashImage(from urlString: String) {
        Task { [weak self] in
            do {
                let image = try await ImageLoader.shared.fetchImage(with: urlString)
                DispatchQueue.main.async {
                    if let image = image {
                        self?.activityIndicator.hide()
                        self?.itemImageView.image = image
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self?.activityIndicator.hide()
                    print("Error fetching images: \(error)")
                }
            }
        }
    }
}
