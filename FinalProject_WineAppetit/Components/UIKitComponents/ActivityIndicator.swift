//
//  ActivityIndicator.swift
//  FinalProject_WineAppetit
//
//  Created by Eka Kelenjeridze on 24.01.24.
//

import UIKit

final class ActivityIndicator: UIView {
    // MARK: - Properties
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        setupBackground()
        addSubviews()
        setupIndicator()
    }
    
    private func setupBackground() {
        backgroundColor = .clear
    }
    
    private func addSubviews() {
        addSubview(activityIndicator)
    }
    
    private func setupIndicator() {
        activityIndicator.startAnimating()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    // MARK: - Methods
    func show() {
        superview?.bringSubviewToFront(self)
        isHidden = false
        activityIndicator.startAnimating()
    }
    
    func hide() {
        removeFromSuperview()
    }
}
