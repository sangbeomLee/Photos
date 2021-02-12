//
//  AppCoordinator.swift
//  Photos
//
//  Created by 이상범 on 2021/02/08.
//

import UIKit

class AppCoordinator: CoordinatorType {
    var parantCoordinator: CoordinatorType? = nil
    var childCoordinators: [CoordinatorType]? = [CoordinatorType]()
    var navigationController: UINavigationController? = UINavigationController()
    var mainController: UIViewController?
    
    func start() {
        let childCoordinator = MainTabBarCoordinator(navigationController: navigationController)
        childCoordinator.parantCoordinator = self
        childCoordinators?.append(childCoordinator)
        
        let mainTabBarController = MainTabBarController()
        mainController = mainTabBarController
        
        childCoordinator.tabBarController = mainTabBarController
        
        childCoordinator.start()
    }
}
