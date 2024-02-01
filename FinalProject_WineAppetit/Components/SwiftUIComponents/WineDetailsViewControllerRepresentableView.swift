//
//  WineDetailsViewControllerRepresentableView.swift
//  FinalProject_WineAppetit
//
//  Created by Eka Kelenjeridze on 01.02.24.
//

import SwiftUI

struct WineDetailsViewControllerRepresentableView:  UIViewControllerRepresentable {
    //MARK: - Properties
    var wineID: Int
    
    //MARK: - Methods
    func makeUIViewController(context: Context) -> UIViewController {
        let wineListViewController = WineDetailsViewController(wineID: wineID)
        return UINavigationController(rootViewController: wineListViewController)
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
}

#Preview {
    WineDetailsViewControllerRepresentableView(wineID: 14)
        .edgesIgnoringSafeArea(.all)
}
