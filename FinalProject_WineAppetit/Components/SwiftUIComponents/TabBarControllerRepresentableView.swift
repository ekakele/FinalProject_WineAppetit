//
//  TabBarControllerRepresentableView.swift
//  FinalProject_WineAppetit
//
//  Created by Eka Kelenjeridze on 11.02.24.
//

import SwiftUI

struct TabBarControllerRepresentableView: UIViewControllerRepresentable {
    // MARK: - Methods
    func makeUIViewController(context: Context) -> TabBarController {
        return TabBarController()
    }
    
    func updateUIViewController(_ uiViewController: TabBarController, context: Context) {
    }
}
