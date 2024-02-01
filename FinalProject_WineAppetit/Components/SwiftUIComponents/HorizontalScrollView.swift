//
//  HorizontalScrollView.swift
//  FinalProject_WineAppetit
//
//  Created by Eka Kelenjeridze on 31.01.24.
//

import SwiftUI

struct HorizontalScrollView: View {
    // MARK: - Properties
    @ObservedObject var viewModel: MyWineLibraryViewModel
    var filteredWines: [Wine]
    
    // MARK: - Body
    var body: some View {
        ZStack {
            backgroundImageView
            wineHorizontalScrollView
        }
        .padding(.horizontal, 8)
    }
    
    // MARK: - Components
    private var wineHorizontalScrollView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            wineHorizontalStackView
        }
        .frame(height: 150)
    }
    
    private var wineHorizontalStackView: some View {
        HStack(spacing: 0) {
            ForEach(filteredWines, id: \.id) { wine in
                ItemCellView(image: wine.image ?? "", wineID: wine.id)
            }
        }
        .padding(.leading, 20)
    }
    
    private var backgroundImageView: some View {
        Image("shelf")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .offset(x: 0, y: 70)
    }
}

#Preview {
    HorizontalScrollView(
        viewModel: MyWineLibraryViewModel(),
        filteredWines: MyWineLibraryViewModel().favoritedWines
    )
}
