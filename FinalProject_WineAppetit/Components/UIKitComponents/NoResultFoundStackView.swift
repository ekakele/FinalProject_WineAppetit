//
//  NoResultFoundStackView.swift
//  FinalProject_WineAppetit
//
//  Created by Eka Kelenjeridze on 28.02.24.
//

import UIKit

final class NoResultFoundStackView: UIStackView {
    // MARK: - Properties
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [noResultImage, noResultLabel])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let noResultLabel: UILabel = {
        let label = UILabel()
        label.text = "No Result Found"
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        return label
    }()
    
    private let noResultImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.AppUIImage.noResult
        imageView.contentMode = .scaleAspectFit
        imageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOpacity = 0.1
        imageView.layer.shadowRadius = 1.5
        imageView.layer.masksToBounds = false
        return imageView
    }()
    
    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        addSubview(mainStackView)
        setupMainStackViewConstraints()
    }
    
    private func setupMainStackViewConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            mainStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
