//
//  View+CornerRadius.swift
//  FinalProject_WineAppetit
//
//  Created by Eka Kelenjeridze on 10.02.24.
//

import SwiftUI

extension View {
    func cornerRadius(radius: CGFloat, corners: UIRectCorner) -> some View {
        ModifiedContent(content: self, modifier: CornerRadiusStyle(radius: radius, corners: corners))
    }
}
