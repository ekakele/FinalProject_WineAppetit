//
//  MenuButton.swift
//  FinalProject_WineAppetit
//
//  Created by Eka Kelenjeridze on 05.02.24.
//

import UIKit

final class MenuButton: UIButton {
    // MARK: - Inits
    init(
        title: String,
        titleColor: UIColor = .label,
        fontSize: CGFloat = 12,
        cornerRadius: CGFloat = 11,
        width: CGFloat = 76,
        height: CGFloat = 34,
        backgroundColor: UIColor = Constants.AppUIColor.lightGray
    ) {
        super.init(frame: .zero)
        
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: fontSize, weight: .light)
        self.layer.cornerRadius = cornerRadius
        self.backgroundColor = backgroundColor
        self.showsMenuAsPrimaryAction = true
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowRadius = 1
        self.layer.masksToBounds = false
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
