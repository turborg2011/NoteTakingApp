//
//  favoritesController.swift
//  NoteTakingApp
//
//  Created by Хайдар Даукаев on 26.01.2024.
//

import UIKit

final class FavoritesController: BaseController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        extendedLayoutIncludesOpaqueBars = true       
    }
}

extension FavoritesController {
    
    override func addViews() {
        super.addViews()
    }
    
    override func layoutViews() {
        super.layoutViews()
    }
    
    override func configure() {
        super.configure()
        
        title = Resources.Strings.NavBar.favorites
        navigationController?.tabBarItem.title = Resources.Strings.TabBar.favorites
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
