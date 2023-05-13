//
//  CustomTabBar.swift
//  NewsToDay
//
//  Created by Sergey on 09.05.2023.
//

import Foundation
import UIKit

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        modalPresentationStyle = .automatic
        modalTransitionStyle = .crossDissolve
        
        let homeNavigationController = UINavigationController(rootViewController: HomeViewController())
        let categoriesNavigationController = UINavigationController(rootViewController: CategoriesViewController())
        let bookmarksNavigationController = UINavigationController(rootViewController: BookmarksViewController())
        let profileNavigationController = UINavigationController(rootViewController: ProfileViewController())
        setViewControllers([homeNavigationController, categoriesNavigationController, bookmarksNavigationController, profileNavigationController], animated: false)
        
        customizeTabBar(homeNavigationController, name: NSLocalizedString("TabBar_Browse", comment: ""))
        customizeTabBar(categoriesNavigationController, name: NSLocalizedString("TabBar_Categories", comment: ""))
        customizeTabBar(bookmarksNavigationController, name: NSLocalizedString("TabBar_Bookmarks", comment: ""))
        customizeTabBar(profileNavigationController, name: NSLocalizedString("TabBar_Profile", comment: ""))
    }
}

private extension CustomTabBarController {
    func customizeTabBar(_ controller: UINavigationController, name: String) {
        controller.viewControllers[0].title = name
        
        switch name {
        case NSLocalizedString("TabBar_Browse", comment: ""):
            controller.tabBarItem.image = UIImage(systemName: "house.circle")
            controller.tabBarItem.selectedImage = UIImage(systemName: "house.circle.fill")
            
            controller.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemTeal]
            controller.navigationBar.prefersLargeTitles = true
            controller.navigationItem.largeTitleDisplayMode = .automatic
            
            if #available(iOS 13.0, *) {
                let navBarApp: UINavigationBarAppearance = UINavigationBarAppearance()
                navBarApp.configureWithDefaultBackground()
                if #available(iOS 15.0, *) {
                    UINavigationBar.appearance().scrollEdgeAppearance = navBarApp
                }
            }
            guard let tabBar = controller.tabBarController?.tabBar else {
                print("ERROR: TabBar is not present (nil)")
                return
            }
            
            tabBar.tintColor = .systemBlue
            tabBar.layer.cornerRadius = 25
            tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            tabBar.layer.masksToBounds = true
            
            if #available(iOS 13.0, *) {
                let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
                tabBarAppearance.configureWithDefaultBackground()
                if #available(iOS 15.0, *) {
                    UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
                }
            }
            
        case NSLocalizedString("TabBar_Categories", comment: ""):
            controller.tabBarItem.image = UIImage(systemName: "square.grid.2x2")
            controller.tabBarItem.selectedImage = UIImage(systemName: "square.grid.2x2.fill")
            
        case NSLocalizedString("TabBar_Bookmarks", comment: ""):
            controller.tabBarItem.image = UIImage(systemName: "bookmark")
            controller.tabBarItem.selectedImage = UIImage(systemName: "bookmark.fill")
            controller.navigationBar.prefersLargeTitles = true
            controller.navigationItem.largeTitleDisplayMode = .automatic
        case NSLocalizedString("TabBar_Profile", comment: ""):
            controller.tabBarItem.image = UIImage(systemName: "person")
            controller.tabBarItem.selectedImage = UIImage(systemName: "person.fill")
        default:
            print("Undefined case")
            break
        }
    }
}
