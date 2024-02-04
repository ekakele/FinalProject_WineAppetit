//
//  TabBarController.swift
//  FinalProject_WineAppetit
//
//  Created by Eka Kelenjeridze on 04.02.24.
//

import UIKit
import SwiftUI

class TabBarController: UITabBarController {
    //MARK: - Properties
    private let wineListViewController = WineListViewController()
    private let calorieCounterViewController = CalorieCounterViewController()
    private let spinTheBottleViewController = SpinTheBottleViewController()
    private let myWineLibraryView = MyWineLibraryView(viewModel: MyWineLibraryViewModel())
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        setupTabBarInitialUI()
        setupTabBar()
    }
    
    //MARK: - Private Methods
    private func setupTabBarInitialUI() {
        tabBar.backgroundColor = .systemBackground
        tabBar.tintColor = Constants.AppUIColor.redFill
    }
    
    private func setupTabBar() {
        let wineListNavigationController = UINavigationController(rootViewController: wineListViewController)
        let wineListTab =  createTabBarItem(
            viewController: wineListNavigationController,
            title: "Wines",
            icon: UIImage(systemName: "list.dash")
        )
        
        let myWineLibraryHostingController = UIHostingController(rootView: myWineLibraryView)
        let myWineLibraryTab =  createTabBarItem(
            viewController: myWineLibraryHostingController,
            title: "My Wine Library",
            icon: UIImage(systemName: "books.vertical.fill")
        )
        
        let calorieCounterTab =  createTabBarItem(
            viewController: calorieCounterViewController,
            title: "Track Calories",
            icon: UIImage(systemName: "figure.yoga")
        )
        
        let spinTheBottleTab =  createTabBarItem(
            viewController: spinTheBottleViewController,
            title: "Game",
            icon: UIImage(systemName: "gamecontroller")
        )
        
        self.setViewControllers([
            wineListTab,
            myWineLibraryTab,
            calorieCounterTab,
            spinTheBottleTab
        ], animated: true)
    }
    
    private func createTabBarItem(viewController: UIViewController, title: String, icon: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = icon
        return viewController
    }
    
}

extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        updateTabBarBackground(for: viewController)
    }
    
    private func updateTabBarBackground(for viewController: UIViewController) {
        if viewController == wineListViewController || viewController is UINavigationController && (viewController as! UINavigationController).viewControllers.first is WineListViewController {
            tabBar.backgroundColor = .systemBackground
            tabBar.tintColor = Constants.AppUIColor.redFill
            tabBar.unselectedItemTintColor = nil
        } else if viewController == calorieCounterViewController || (viewController as? UINavigationController)?.viewControllers.first is CalorieCounterViewController {
            tabBar.backgroundColor = .clear
            tabBar.isTranslucent = true
            tabBar.tintColor = Constants.AppUIColor.redFill
            tabBar.unselectedItemTintColor = Constants.AppUIColor.burgundy.withAlphaComponent(0.5)
        } else {
            tabBar.backgroundColor = .clear
            tabBar.isTranslucent = true
            tabBar.tintColor = Constants.AppUIColor.lightGreen
            tabBar.unselectedItemTintColor = Constants.AppUIColor.darkGreen
        }
    }
}
