//
//  ShortInfoStackView.swift
//  FinalProject_WineAppetit
//
//  Created by Eka Kelenjeridze on 23.01.24.
//

import UIKit

final class ShortInfoStackView: UIStackView {
    // MARK: - Inits
    init(
        arrangedSubviews: [UIView],
        axis: NSLayoutConstraint.Axis = .vertical,
        distribution: UIStackView.Distribution = .equalSpacing,
        stackAlignment: UIStackView.Alignment? = .center,
        stackSpacing: CGFloat? = nil
    ) {
        super.init(frame: .zero)
        
        arrangedSubviews.forEach { self.addArrangedSubview($0) }
        self.axis = axis
        self.distribution = distribution
        self.alignment = stackAlignment ?? .fill
        self.spacing = stackSpacing ?? 0
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
