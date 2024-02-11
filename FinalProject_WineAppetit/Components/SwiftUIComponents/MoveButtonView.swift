//
//  MoveButtonView.swift
//  FinalProject_WineAppetit
//
//  Created by Eka Kelenjeridze on 10.02.24.
//

import SwiftUI

struct MoveButtonView: View {
    // MARK: - Properties
    var iconImage: String
    var action: () -> Void
    
    // MARK: - Body
    var body: some View {
        Button(action: action) {
            Image(systemName: iconImage)
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundStyle(Color.secondary)
        }
    }
}

#Preview {
    MoveButtonView(iconImage: "chevron.forward.circle", action: {})
}
