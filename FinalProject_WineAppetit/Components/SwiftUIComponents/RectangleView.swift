//
//  RectangleView.swift
//  FinalProject_WineAppetit
//
//  Created by Eka Kelenjeridze on 10.02.24.
//

import SwiftUI

struct RectangleView: View {
    // MARK: - Properties
    let cornerRadius: CGFloat
    let corners: UIRectCorner
    let backgroundColor: Color
    
    // MARK: - Body
    var body: some View {
        Rectangle()
            .cornerRadius(radius: cornerRadius, corners: [corners])
            .cornerRadius(3)
            .frame(maxHeight: 350)
            .foregroundColor(backgroundColor)
            .padding(.horizontal, 20)
            .frame(maxHeight: .infinity, alignment: .bottom)
    }
}

#Preview {
    RectangleView(cornerRadius: 100, corners: [.topLeft, .bottomRight], backgroundColor: Constants.AppColor.shadeBackground)
}
