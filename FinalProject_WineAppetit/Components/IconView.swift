//
//  IconView.swift
//  FinalProject_WineAppetit
//
//  Created by Eka Kelenjeridze on 26.01.24.
//

import UIKit

class IconView: UIView {
    //MARK: - Inits
    init(
        backgroundColor: UIColor = Constants.AppColor.iconBackground, 
        cornerRadius: CGFloat = 14,
        height: CGFloat = 54,
        width: CGFloat = 100
    ) {
        super.init(frame: .zero)
        
        self.backgroundColor = backgroundColor
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadius
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
