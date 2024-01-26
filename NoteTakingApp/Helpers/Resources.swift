//
//  Resources.swift
//  NoteTakingApp
//
//  Created by Хайдар Даукаев on 26.01.2024.
//

import UIKit

enum Resources {
    
    enum Colors {
        static let active = UIColor(hexString: "#437BFE")
        static let inactive = UIColor(hexString: "#929DA5")
        
        static let background = UIColor(hexString: "#F8F9F9")
        static let separator = UIColor(hexString: "#E8ECEF")
        static let secondary = UIColor(hexString: "#D8D8D8")
        
        static let titleGrey = UIColor(hexString: "#545C77")
    }
    
    enum Strings {
        enum TabBar {
            static let allNotes = "Все заметки"
            static let favorites = "Избранное"
        }
        
        enum NavBar {
            static let allNotes = "Все заметки"
            static let favorites = "Избранное"
        }
    }
    
    enum Images {
        enum TabBar {
            static let allNotes = UIImage(systemName: "square.and.pencil")
            static let favorites = UIImage(systemName: "star")
        }
    }
    
    enum Fonts {
        static func helveticaRegular(with size: CGFloat) -> UIFont {
            UIFont(name: "Helvetica", size: size) ?? UIFont()
        }
    }
}
