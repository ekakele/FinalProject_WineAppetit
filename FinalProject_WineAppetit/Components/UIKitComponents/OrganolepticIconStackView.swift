//
//  organolepticIconStackView.swift
//  FinalProject_WineAppetit
//
//  Created by Eka Kelenjeridze on 26.01.24.
//

import UIKit

final class OrganolepticIconStackView: UIView {
    // MARK: - Properties
    private let IconStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let eyeIconImageView = InfographicIcon(
        systemName: "eye",
        tintColor: .white,
        height: 28,
        width: 28
    )
    
    private let noseIconImageView = InfographicIcon(
        systemName: "nose",
        tintColor: .white,
        height: 28,
        width: 28
    )
    
    private let mouthIconImageView = InfographicIcon(
        systemName: "mouth",
        tintColor: .white,
        height: 28,
        width: 28
    )
    
    private let colorIconView = IconView()
    private let aromaIconView = IconView()
    private let tasteIconView = IconView()
    
    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        addSubviews()
        setupIconStackViewConstraints()
    }
    
    private func addSubviews() {
        addSubview(IconStackView)
        
        IconStackView.addArrangedSubview(colorIconView)
        IconStackView.addArrangedSubview(aromaIconView)
        IconStackView.addArrangedSubview(tasteIconView)
        
        setupIconImageView(eyeIconImageView, in: colorIconView)
        setupIconImageView(noseIconImageView, in: aromaIconView)
        setupIconImageView(mouthIconImageView, in: tasteIconView)
        
    }
    
    private func setupIconStackViewConstraints() {
        NSLayoutConstraint.activate([
            IconStackView.topAnchor.constraint(equalTo: topAnchor),
            IconStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            IconStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            IconStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupIconImageView(_ imageView: UIImageView, in iconView: UIView) {
        iconView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: iconView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: iconView.centerYAnchor)
        ])
    }
}
