//
//  TabBarController.swift
//  FinalProject_WineAppetit
//
//  Created by Eka Kelenjeridze on 04.02.24.
//

import UIKit
import SwiftUI

final class TabBarController: UITabBarController {
    // MARK: - Properties
    private let wineListViewController = WineListViewController()
    private let wineRandomizerViewController = WineRandomizerViewController()
    private let myWineLibraryView = MyWineLibraryView(viewModel: MyWineLibraryViewModel())
    private let calorieCounterViewController = CalorieCounterViewController()
    private let spinTheBottleViewController = SpinTheBottleViewController()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        tabBarInitialConfiguration()
        setupViewControllers()
    }
    
    // MARK: - Private Methods
    private func tabBarInitialConfiguration() {
        configureTabBar(
            backgroundColor: .systemBackground,
            tintColor: Constants.AppUIColor.redFill,
            unselectedItemTintColor: nil,
            isTranslucent: false
        )
    }
    
    private func setupViewControllers() {
        let viewControllers = [
            createNavigationController(
                for: wineListViewController,
                title: "Wines",
                icon: "list.dash"
            ),
            
            createNavigationController(
                for: wineRandomizerViewController,
                title: "Randomizer",
                icon: "arcade.stick.and.arrow.up.and.arrow.down"
            ),
            
            createHostingController(
                for: myWineLibraryView,
                title: "My Wine Library",
                icon: "books.vertical.fill"
            ),
            
            createNavigationController(
                for: calorieCounterViewController,
                title: "Calorie Tracker",
                icon: "figure.yoga"
            ),
            
            createNavigationController(
                for: spinTheBottleViewController,
                title:  "Game",
                icon: "gamecontroller"
            )
        ]
        self.setViewControllers(viewControllers, animated: true)
    }

    private func createNavigationController(for rootViewController: UIViewController, title: String, icon: String) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.tabBarItem = UITabBarItem(title: title, image: UIImage(systemName: icon), selectedImage: nil)
        return navigationController
    }
    
    private func createHostingController<T: View>(for rootView: T, title: String, icon: String) -> UIHostingController<T> {
        let hostingController = UIHostingController(rootView: rootView)
        hostingController.tabBarItem = UITabBarItem(title: title, image: UIImage(systemName: icon), selectedImage: nil)
        return hostingController
    }
}

// MARK: - UITabBarControllerDelegate
extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        updateTabBarBackground(for: viewController)
    }
    
    private func updateTabBarBackground(for viewController: UIViewController) {
        let isWineViewController = isViewControllerOfType(viewController, type: WineListViewController.self) || isViewControllerOfType(viewController, type: WineRandomizerViewController.self)
        
        let isCalorieCounterViewController = isViewControllerOfType(viewController, type: CalorieCounterViewController.self)
        
        if isWineViewController {
            configureTabBar(
                backgroundColor: .systemBackground,
                tintColor: Constants.AppUIColor.redFill,
                unselectedItemTintColor: nil,
                isTranslucent: false
            )
        } else if isCalorieCounterViewController {
            configureTabBar(
                backgroundColor: .clear,
                tintColor: Constants.AppUIColor.redFill,
                unselectedItemTintColor: Constants.AppUIColor.burgundy.withAlphaComponent(0.5),
                isTranslucent: true
            )
        } else {
            configureTabBar(
                backgroundColor: .clear,
                tintColor: Constants.AppUIColor.lightGreen,
                unselectedItemTintColor: Constants.AppUIColor.darkGreen,
                isTranslucent: true
            )
        }
    }

    private func configureTabBar(backgroundColor: UIColor, tintColor: UIColor, unselectedItemTintColor: UIColor?, isTranslucent: Bool) {
        tabBar.backgroundColor = backgroundColor
        tabBar.tintColor = tintColor
        tabBar.unselectedItemTintColor = unselectedItemTintColor
        tabBar.isTranslucent = isTranslucent
    }
    
    private func isViewControllerOfType<T: UIViewController>(_ viewController: UIViewController, type: T.Type) -> Bool {
        if viewController is T {
            return true
        } else if let navigationController = viewController as? UINavigationController,
                  navigationController.viewControllers.first is T {
            return true
        }
        return false
    }
}
