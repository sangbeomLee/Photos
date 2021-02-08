//
//  AppDelegate.swift
//  Photos
//
//  Created by 이상범 on 2021/02/08.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let coordinator = AppCoordinator()
        coordinator.start()
        self.coordinator = coordinator
        
        let window = UIWindow()
        window.rootViewController = coordinator.navigationController
        window.makeKeyAndVisible()
        self.window = window
        
        return true
    }

}

