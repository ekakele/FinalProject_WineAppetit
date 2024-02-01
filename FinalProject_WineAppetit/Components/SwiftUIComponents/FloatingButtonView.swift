//
//  AddButtonView.swift
//  FinalProject_WineAppetit
//
//  Created by Eka Kelenjeridze on 01.02.24.
//

import SwiftUI

struct FloatingButtonView: View {
    //MARK: - Properties
    var buttonIcon: String
    var action: () -> Void
    @Binding var isPresentingWineListView: Bool
    
    //MARK: - Body
    var body: some View {
        buttonView
    }
    
    //MARK: - Components
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
            .frame(width: 12, height: 12)
            .font(.title.weight(.bold))
            .padding()
            .background(Constants.AppColor.lightGreen)
            .opacity(0.8)
            .foregroundColor(Constants.AppColor.greenBackground)
            .clipShape(Circle())
            .shadow(color: Constants.AppColor.darkGreen, radius: 4, x: 0.1, y: 0.1)
    }
}

#Preview {
    FloatingButtonView(buttonIcon: "plus", action: {}, isPresentingWineListView: .constant(false))
}
