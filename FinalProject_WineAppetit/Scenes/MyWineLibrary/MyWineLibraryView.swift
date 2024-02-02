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
    @State private var zoomedWineID: Int?
    
    //MARK: - Body
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
    }
    
    private var scrollingSectionAndButtonView: some View {
        ZStack(alignment: .bottomTrailing) {
            scrollingSectionsView
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
    
    private var scrollingSectionsView: some View {
        ScrollView {
            generateSectionStackView()
        }
        .padding(.top, 20)
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
                filteredWines: filteredWines,
                zoomedWineID: $zoomedWineID
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
