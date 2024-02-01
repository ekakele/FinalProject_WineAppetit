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
    @State private var isPresentingWineListView = false
    
    //MARK: - Body
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            backgroundView
            
            ScrollView {
                generateSectionStackView()
            }
            .padding(.top, 20)
            
            setupFloatingButtonView
        }
    }
    
    private var setupFloatingButtonView: some View {
        FloatingButtonView(
            buttonIcon: "plus",
            action: { isPresentingWineListView.toggle() }, isPresentingWineListView: $isPresentingWineListView
        )
        .sheet(
            isPresented: $isPresentingWineListView,
            onDismiss: viewModel.refreshData,
            content: { wineListRepresentableView }
        )
    }
    
    private var wineListRepresentableView: some View {
        WineListViewControllerRepresentableView()
            .edgesIgnoringSafeArea(.all)
    }
    
    private func generateSectionStackView() -> some View {
        VStack(alignment: .leading, spacing: 34) {
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
        VStack() {
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
            
            Image("lighting")
                .resizable()
                .ignoresSafeArea(.all)
                .opacity(0.5)
        }
    }
}

#Preview {
    MyWineLibraryView(viewModel: MyWineLibraryViewModel())
}
