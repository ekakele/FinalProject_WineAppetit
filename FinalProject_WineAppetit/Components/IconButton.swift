//
//  IconButton.swift
//  FinalProject_WineAppetit
//
//  Created by Eka Kelenjeridze on 29.01.24.
//

import UIKit

class IconButton: UIButton {
    //MARK: - Inits
    init(imageName: String, tintColor: UIColor? = nil) {
        super.init(frame: .zero)
        
        self.setImage(UIImage(systemName: imageName), for: .normal)
        self.tintColor = tintColor ?? .label
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
