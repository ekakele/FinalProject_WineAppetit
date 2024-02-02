//
//  ItemCellView.swift
//  FinalProject_WineAppetit
//
//  Created by Eka Kelenjeridze on 31.01.24.
//

import SwiftUI

struct ItemCellView: View {
    // MARK: - Properties
    var image: String
    var wineID: Int
    @State private var isPresentingWineListView = false
    @ObservedObject var viewModel: MyWineLibraryViewModel
    
    // MARK: - Body
    var body: some View {
        itemImageView
            .onTapGesture {
                isPresentingWineListView.toggle()
            }
            .sheet(
                isPresented: $isPresentingWineListView,
                onDismiss: viewModel.refreshData,
                content: { wineDetailsRepresentableView }
            )
    }
    
    // MARK: - Components
    private var wineDetailsRepresentableView: some View {
        WineDetailsViewControllerRepresentableView(wineID: wineID)
            .edgesIgnoringSafeArea(.all)
    }
    
    private var itemImageView: some View {
        fetchImage()
    }
    
    private func fetchImage() -> some View {
        let imageURL = URL(string: image)
        
        return AsyncImage(
            url: imageURL,
            content: { fetchedImage in
                fetchedImage
                    .resizable()
                    .scaledToFit()
                    .frame(height: 150, alignment: .center)
                    .shadow(color: Constants.AppColor.lightGreen, radius: 1)
            }, placeholder: {
                ProgressView()
            })
    }
}

#Preview {
    ItemCellView(image: "testWine", wineID: 6, viewModel: MyWineLibraryViewModel())
}
