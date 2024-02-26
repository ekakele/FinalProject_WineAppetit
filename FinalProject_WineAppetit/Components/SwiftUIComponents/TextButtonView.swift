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
    let textColor: Color
    let fontSize: CGFloat
    let fontWeight: Font.Weight
    let action: () -> Void
    
    // MARK: - Body
    var body: some View {
        Button(action: action) {
            Text(title)
                .foregroundColor(textColor)
                .font(.system(size: fontSize, weight: fontWeight))
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
}

#Preview {
    TextButtonView(title: "Skip", textColor: Constants.AppColor.textColor, fontSize: 16, fontWeight: .regular, action: {})
}
