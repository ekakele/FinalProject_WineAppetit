//
//  ScanningLineView.swift
//  FinalProject_WineAppetit
//
//  Created by Eka Kelenjeridze on 27.02.24.
//

import SwiftUI

struct ScanningLineView: View {
    // MARK: - Properties
    @State private var moveUpAndDown = false
    
    // MARK: - Body
    var body: some View {
        GeometryReader { geometry in
            rectangleView
                .offset(y: moveUpAndDown ? 0 : geometry.size.height - 2)
                .animation(
                    Animation.linear(duration: 2.5).repeatForever(autoreverses: true),
                    value: moveUpAndDown
                )
                .onAppear {
                    moveUpAndDown.toggle()
                }
        }
    }
    
    // MARK: - Components
    private var rectangleView: some View {
        Rectangle()
            .fill(Color.red)
            .frame(height: 2)
            .opacity(0.8)
            .shadow(color: .red, radius: 5)
    }
}

#Preview {
    ScanningLineView()
}
