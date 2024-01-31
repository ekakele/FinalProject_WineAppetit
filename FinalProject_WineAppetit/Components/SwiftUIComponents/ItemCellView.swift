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
    @State private var isZoomed: Bool = false
    
    // MARK: - Body
    var body: some View {
        itemImageView
    }
    
    // MARK: - Components
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
                //                ProgressView() TODO: - ბოლოს ეს დავტოვო
                Image("testWine")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: isZoomed ? 350 : 150)
                    .shadow(color: Constants.AppColor.lightGreen, radius: 1)
            })
    }
}

#Preview {
    ItemCellView(image: "testWine")
}
