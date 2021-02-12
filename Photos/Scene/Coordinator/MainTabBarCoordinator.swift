//
//  MainTabBarViewController.swift
//  Photos
//
//  Created by 이상범 on 2021/02/09.
//

import UIKit

class MainTabBarCoordinator: CoordinatorType {
    var parantCoordinator: CoordinatorType?
    var childCoordinators: [CoordinatorType]?
    var navigationController: UINavigationController?
    var tabBarController: MainTabBarController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
        childCoordinators = []
    }
    
    func start() {
        guard let navigationController = navigationController else { return }
        tabBarController?.coordinator = self
        
        let photosNavigationController = navigationController
        photosNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
        let photosCoordinator = PhotosCoordinator(navigationController: photosNavigationController)
        
        let searchNavigaionController = UINavigationController()
        searchNavigaionController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        let searchCoordinator = PhotoSearchCoordinator(navigationController: searchNavigaionController)
 
        tabBarController?.viewControllers = [photosNavigationController, searchNavigaionController]
        
        childCoordinators?.append(photosCoordinator)
        childCoordinators?.append(searchCoordinator)
        
        childCoordinators?.forEach { $0.start() }
    }
}
