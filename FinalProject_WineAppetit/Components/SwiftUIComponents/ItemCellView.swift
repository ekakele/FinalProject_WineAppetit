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
    @Binding var zoomedWineID: Int?
    private var isZoomed: Bool {
        zoomedWineID == wineID
    }
    
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
            .onLongPressGesture(minimumDuration: 0.5) {
                withAnimation(.spring) {
                    zoomedWineID = isZoomed ? nil : wineID
                }
            }
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
                    .frame(height: isZoomed ? 220 : 150, alignment: .center)
                    .shadow(color: Constants.AppColor.lightGreen, radius: 1)
            }, placeholder: {
                ProgressView()
            })
    }
}

#Preview {
    ItemCellView(image: "testWine", wineID: 6, viewModel: MyWineLibraryViewModel(), zoomedWineID: .constant(8))
}
