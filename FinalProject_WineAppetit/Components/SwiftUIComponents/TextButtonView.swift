//
//  TextButtonView.swift
//  FinalProject_WineAppetit
//
//  Created by Eka Kelenjeridze on 10.02.24.
//

import SwiftUI

struct TextButtonView: View {
    // MARK: - Properties
    let title: String
    let fontSize: CGFloat
    let fontWeight: Font.Weight
    var action: () -> Void
    
    // MARK: - Body
    var body: some View {
        Button(action: action) {
            Text(title)
                .foregroundColor(Constants.AppColor.textColor)
                .font(.system(size: fontSize, weight: fontWeight))
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
}

#Preview {
    TextButtonView(title: "Skip", fontSize: 16, fontWeight: .regular, action: {})
}
