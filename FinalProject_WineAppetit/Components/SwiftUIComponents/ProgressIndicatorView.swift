//
//  ProgressIndicatorView.swift
//  FinalProject_WineAppetit
//
//  Created by Eka Kelenjeridze on 10.02.24.
//

import SwiftUI

struct ProgressIndicatorView: View {
    // MARK: - Properties
    let pageCount: Int
    let currentIndex: Int
    
    // MARK: - Body
    var body: some View {
        HStack(spacing: 10) {
            ForEach(0..<pageCount, id: \.self) { index in
                Circle()
                    .fill(index == currentIndex ? Color.gray : .gray.opacity(0.4))
                    .frame(width: 10, height: 10)
            }
        }
    }
}

#Preview {
    ProgressIndicatorView(pageCount: 5, currentIndex: 3)
}
