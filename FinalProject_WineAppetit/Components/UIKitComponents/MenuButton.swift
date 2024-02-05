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
        titleColor: UIColor,
        cornerRadius: CGFloat,
        height: CGFloat,
        backgroundColor: UIColor
    ) {
        super.init(frame: .zero)
        
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
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
