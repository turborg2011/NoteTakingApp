//
//  BaseController.swift
//  NoteTakingApp
//
//  Created by Хайдар Даукаев on 26.01.2024.
//

import UIKit

class BaseController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
        layoutViews()
        configure()
    }
}

// @objc нужно чтобы переопределять функции
// этого расширения в дочерних классах
@objc extension BaseController {
    
    func addViews() {}
    func layoutViews() {}
    func configure() {
        view.backgroundColor = .systemBackground
    }
}
