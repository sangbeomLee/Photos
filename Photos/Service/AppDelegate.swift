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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow()
        let mainVC = PhotosViewController(nibName: "PhotosViewController", bundle: nil)
        let navigationVC = UINavigationController(rootViewController: mainVC)
        window?.rootViewController = navigationVC
        window?.makeKeyAndVisible()
        
        return true
    }

}

