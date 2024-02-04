//
//  CustomLabel.swift
//  FinalProject_WineAppetit
//
//  Created by Eka Kelenjeridze on 23.01.24.
//

import UIKit

final class CustomLabel: UILabel {
    // MARK: - Inits
    init(
        textColor: UIColor,
        font: UIFont,
        numberOfLines: Int
    ) {
        super.init(frame: .zero)
        
        self.textColor = textColor
        self.font = font
        self.numberOfLines = numberOfLines
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
