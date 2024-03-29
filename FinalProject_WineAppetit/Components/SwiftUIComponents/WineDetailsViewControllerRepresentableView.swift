//
//  WineDetailsViewControllerRepresentableView.swift
//  FinalProject_WineAppetit
//
//  Created by Eka Kelenjeridze on 01.02.24.
//

import SwiftUI

struct WineDetailsViewControllerRepresentableView:  UIViewControllerRepresentable {
    // MARK: - Properties
    var wineID: Int
    var isBarcode: Bool = false
    
    // MARK: - Methods
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = WineDetailsViewController(wineID: wineID, isBarcode: isBarcode)
        return UINavigationController(rootViewController: viewController)
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
}

#Preview {
    WineDetailsViewControllerRepresentableView(wineID: 14)
        .edgesIgnoringSafeArea(.all)
}
