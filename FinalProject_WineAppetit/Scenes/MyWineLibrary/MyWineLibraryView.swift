//
//  MyWineLibraryView.swift
//  FinalProject_WineAppetit
//
//  Created by Eka Kelenjeridze on 31.01.24.
//

import SwiftUI

struct MyWineLibraryView: View {
    //MARK: - Properties
    @StateObject var viewModel: MyWineLibraryViewModel
    
    //MARK: - Body
    var body: some View {
        ZStack {
            backgroundView
            
            ScrollView {
                generateSectionStackView()
            }
            .padding(.top, 20)
        }
    }
    
    private func generateSectionStackView() -> some View {
        VStack(alignment: .leading, spacing: 40) {
            generateTitledSectionView(
                title: "Red Wines",
                filteredWines: viewModel.filteredWines(category: "red")
            )
            generateTitledSectionView(
                title: "White Wines",
                filteredWines: viewModel.filteredWines(category: "white")
            )
            generateTitledSectionView(
                title: "Rose Wines",
                filteredWines: viewModel.filteredWines(category: "rose")
            )
        }
    }
    
    private func generateTitledSectionView(title: String, filteredWines: [Wine]) -> some View {
        VStack(/*spacing: 14*/) {
            ShelfTitleView(title: title)
            Spacer()
            HorizontalScrollView(
                viewModel: viewModel,
                filteredWines: filteredWines
            )
        }
    }
    
    private var backgroundView: some View {
        ZStack {
            Constants.AppColor.greenBackground
                .edgesIgnoringSafeArea(.all)
            
            Image("light")
                .resizable()
                .ignoresSafeArea(.all)
                .opacity(0.5)
        }
    }
}

#Preview {
    MyWineLibraryView(viewModel: MyWineLibraryViewModel())
}
