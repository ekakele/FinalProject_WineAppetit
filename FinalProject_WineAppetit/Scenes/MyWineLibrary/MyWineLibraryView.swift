//
//  MyWineLibraryView.swift
//  FinalProject_WineAppetit
//
//  Created by Eka Kelenjeridze on 31.01.24.
//

import SwiftUI

struct MyWineLibraryView: View {
    // MARK: - Properties
    @StateObject var viewModel: MyWineLibraryViewModel
    @State private var isPresentingWineListView = false
    @State private var zoomedWineID: Int?
    
    // MARK: - Body
    var body: some View {
        ZStack() {
            backgroundView
                .onTapGesture {
                    if zoomedWineID != nil {
                        withAnimation(.spring) {
                            zoomedWineID = nil
                        }
                    }
                }
                .allowsHitTesting(zoomedWineID != nil)
            
            scrollingSectionAndButtonView
                .allowsHitTesting(zoomedWineID == nil)
        }
        .onAppear {
            viewModel.refreshData()
        }
    }
    
    // MARK: - Components
    private var scrollingSectionAndButtonView: some View {
        ZStack(alignment: .bottomTrailing) {
            generateSectionStackView()
            setupFloatingButtonView
        }
        .padding(.top, 10)
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
        VStack(spacing: 0) {
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
            Spacer()
        }
    }
    
    private func generateTitledSectionView(title: String, filteredWines: [Wine]) -> some View {
        VStack() {
            ShelfTitleView(title: title)
            HorizontalScrollView(
                viewModel: viewModel,
                filteredWines: filteredWines,
                zoomedWineID: $zoomedWineID
            )
            Spacer()
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
