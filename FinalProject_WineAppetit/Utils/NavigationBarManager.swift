//
//  NavigationBarTitle.swift
//  FinalProject_WineAppetit
//
//  Created by Eka Kelenjeridze on 12.02.24.
//

import UIKit

final class NavigationBarManager {
    static func setupNavigationBar(for viewController: UIViewController, title: String) {
        viewController.navigationItem.title = title
        viewController.navigationController?.navigationBar.prefersLargeTitles = true
        if #available(iOS 17.0, *) {
            viewController.navigationItem.largeTitleDisplayMode = .inline
        } else {
            viewController.navigationItem.largeTitleDisplayMode = .automatic
        }
    }
}
