//
//  AddButtonView.swift
//  FinalProject_WineAppetit
//
//  Created by Eka Kelenjeridze on 01.02.24.
//

import SwiftUI

struct FloatingButtonView: View {
    // MARK: - Properties
    let backgroundColor: Color
    let foregroundColor: Color
    let shadowColor: Color
    let buttonIcon: String
    let action: () -> Void
    @Binding var isPresentingWineListView: Bool
    
    // MARK: - Body
    var body: some View {
        buttonView
    }
    
    // MARK: - Components
    private var buttonView: some View {
        Button {
            action()
        } label: {
            buttonImageView
        }
        .padding()
    }
    
    private var buttonImageView: some View {
        Image(systemName: buttonIcon)
            .resizable()
            .frame(width: 16, height: 16)
            .font(.largeTitle.weight(.bold))
            .padding()
            .background(backgroundColor)
            .foregroundColor(foregroundColor)
            .clipShape(Circle())
            .shadow(color: shadowColor, radius: 3, x: 0.1, y: 0.1)
    }
}

#Preview {
    FloatingButtonView(
        backgroundColor: Constants.AppColor.lightGreen,
        foregroundColor: Constants.AppColor.greenBackground,
        shadowColor: .black, 
        buttonIcon: "plus",
        action: {},
        isPresentingWineListView: .constant(false)
    )
}
