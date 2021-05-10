//
//  AppDelegate.swift
//  tmdb
//
//  Created by toha on 09.05.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let vc = MoviesListViewController()
        let nc = RootNavigationController(rootViewController: vc)

        window = UIWindow()
        window?.makeKeyAndVisible()
        window?.rootViewController = nc
        
        return true
    }


}

