//
//  WineListViewControllerRepresentableView.swift
//  FinalProject_WineAppetit
//
//  Created by Eka Kelenjeridze on 01.02.24.
//

import SwiftUI

struct WineListViewControllerRepresentableView: UIViewControllerRepresentable {
    // MARK: - Methods
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = WineListViewController()
        return UINavigationController(rootViewController: viewController)
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
}

#Preview {
    WineListViewControllerRepresentableView()
        .edgesIgnoringSafeArea(.all)
}
