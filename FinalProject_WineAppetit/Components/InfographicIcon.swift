//
//  InfographicIcon.swift
//  FinalProject_WineAppetit
//
//  Created by Eka Kelenjeridze on 26.01.24.
//

import UIKit

final class InfographicIcon: UIImageView {
    //MARK: - Inits
    init(
        systemName: String,
        tintColor: UIColor = .gray,
        height: CGFloat? = nil,
        width: CGFloat? = nil
    ) {
        super.init(frame: .zero)
        
        self.image = UIImage(systemName: systemName)
        self.tintColor = tintColor
        self.contentMode = .scaleAspectFit
        self.clipsToBounds = true
        
        
        self.translatesAutoresizingMaskIntoConstraints = false
        if let height = height {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        if let width = width {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
