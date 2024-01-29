//
//  IconLabelStackView.swift
//  FinalProject_WineAppetit
//
//  Created by Eka Kelenjeridze on 26.01.24.
//

import UIKit

final class IconLabelStackView: UIStackView {
    //MARK: - Inits
    init() {
        super.init(frame: .zero)
        self.axis = .vertical
        self.spacing = 2
        self.distribution = .fillEqually
        self.backgroundColor = Constants.AppColor.tagBackground
        self.clipsToBounds = true
        self.layer.cornerRadius = 14
        self.isLayoutMarginsRelativeArrangement = true
        self.layoutMargins = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        
        self.heightAnchor.constraint(equalToConstant: 54).isActive = true
        self.widthAnchor.constraint(equalToConstant: 54).isActive = true
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
}
