//
//  MenuButton.swift
//  FinalProject_WineAppetit
//
//  Created by Eka Kelenjeridze on 05.02.24.
//

import UIKit

class MenuButton: UIButton {
    // MARK: - Inits
    init(
        title: String,
        titleColor: UIColor = .label,
        fontSize: CGFloat = 14,
        cornerRadius: CGFloat = 8,
        height: CGFloat = 40,
        backgroundColor: UIColor = .systemPink.withAlphaComponent(0.3)
    ) {
        super.init(frame: .zero)
        
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        self.layer.cornerRadius = cornerRadius
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
        self.backgroundColor = backgroundColor
        
        self.showsMenuAsPrimaryAction = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
