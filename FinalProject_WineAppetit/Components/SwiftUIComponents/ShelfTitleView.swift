//
//  ShelfTitleView.swift
//  FinalProject_WineAppetit
//
//  Created by Eka Kelenjeridze on 31.01.24.
//

import SwiftUI

struct ShelfTitleView: View {
    // MARK: - Properties
    let title: String
    
    // MARK: - Body
    var body: some View {
        overlayLayersView
    }
    
    // MARK: - Components
    private var overlayLayersView: some View {
        filledRectangleView
            .overlay(rectangleStrokeView)
            .overlay(titleView)
    }
    
    private var titleView: some View {
        Text(title)
            .foregroundColor(Constants.AppColor.lightGreen)
            .font(.system(size: 16))
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
    }
    
    private var rectangleStrokeView: some View {
        RoundedRectangle(cornerRadius: 20)
            .stroke(Constants.AppColor.lightGreen, lineWidth: 1)
            .shadow(color: Constants.AppColor.lightGreen, radius: 3)
    }
    
    private var filledRectangleView: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(Constants.AppColor.darkGreen)
            .frame(width: 120, height: 36)
    }
}

#Preview {
    ShelfTitleView(title: "White Wines")
}
