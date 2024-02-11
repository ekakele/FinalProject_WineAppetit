//
//  CornerRadiusStyle.swift
//  FinalProject_WineAppetit
//
//  Created by Eka Kelenjeridze on 10.02.24.
//

import SwiftUI

struct CornerRadiusStyle: ViewModifier {
    // MARK: - Properties
    var radius: CGFloat
    var corners: UIRectCorner
    
    // MARK: - Methods
    func body(content: Content) -> some View {
        content
            .clipShape(CornerRadiusShape(radius: radius, corners: corners))
    }
}

struct CornerRadiusShape: Shape {
    // MARK: - Properties
    var radius = CGFloat.infinity
    var corners = UIRectCorner.allCorners
    
    // MARK: - Methods
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
