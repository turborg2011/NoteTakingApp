//
//  TabBarController.swift
//  NoteTakingApp
//
//  Created by Хайдар Даукаев on 26.01.2024.
//

import UIKit

enum Tabs: Int {
    case allNotes
    case favorites
}

class TabBarController: UITabBarController {
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        configureAppearance()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureAppearance() {
        
        tabBar.tintColor = Resources.Colors.active
        tabBar.barTintColor = Resources.Colors.inactive
//        tabBar.backgroundColor = .systemBackground
//        
        tabBar.layer.masksToBounds = true
        tabBar.isTranslucent = false
        
        let appearance = tabBar.standardAppearance
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBackground
        tabBar.standardAppearance = appearance
        
        let allNotesController = AllNotesController()
        let favoritesController = FavoritesController()
        
        let allNotesNavigation = UINavigationController(rootViewController: allNotesController)
        let favoritesNavigation = UINavigationController(rootViewController: favoritesController)
        
        allNotesNavigation.tabBarItem = UITabBarItem(title: Resources.Strings.TabBar.allNotes,
                                                     image: Resources.Images.TabBar.allNotes,
                                                     tag: Tabs.allNotes.rawValue)
        favoritesNavigation.tabBarItem = UITabBarItem(title: Resources.Strings.TabBar.favorites,
                                                      image: Resources.Images.TabBar.favorites,
                                                      tag: Tabs.favorites.rawValue)
        
        setViewControllers([
            allNotesNavigation,
            favoritesNavigation
        ], animated: false)
    }
}
