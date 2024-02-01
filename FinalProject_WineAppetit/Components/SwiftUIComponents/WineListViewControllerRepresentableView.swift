//
//  WineListViewControllerRepresentableView.swift
//  FinalProject_WineAppetit
//
//  Created by Eka Kelenjeridze on 01.02.24.
//

import SwiftUI

struct WineListViewControllerRepresentableView: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> UIViewController {
        let wineListViewController = WineListViewController()
        return UINavigationController(rootViewController: wineListViewController)
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
}

#Preview {
    WineListViewControllerRepresentableView()
        .edgesIgnoringSafeArea(.all)
}
