//
//  MainTitleView.swift
//  FinalProject_WineAppetit
//
//  Created by Eka Kelenjeridze on 27.02.24.
//

import SwiftUI

struct MainTitleView: View {
    // MARK: - Properties
    let title: String
    let textSize: CGFloat
    let textWeight: Font.Weight?
    let textColor: Color
    
    // MARK: - Body
    var body: some View {
        Text(title)
            .font(.system(size: textSize))
            .fontWeight(textWeight)
            .foregroundStyle(textColor)
            .padding()
    }
}

#Preview {
    MainTitleView(
        title: "Scan Wine Bottle's Barcode",
        textSize: 24,
        textWeight: .bold,
        textColor: .secondary
    )
}


