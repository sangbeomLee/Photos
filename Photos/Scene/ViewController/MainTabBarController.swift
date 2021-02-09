//
//  MainTabViewController.swift
//  Photos
//
//  Created by 이상범 on 2021/02/09.
//

import UIKit

class MainTabBarController: UITabBarController {
    let coordinator = MainTabBarCoordinator(navigationController: UINavigationController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coordinator.tabBarController = self
        coordinator.start()
    }
}
