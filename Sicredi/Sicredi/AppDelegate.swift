//
//  AppDelegate.swift
//  Sicredi
//
//  Created by Victor Rodrigues on 08/11/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        window?.makeKeyAndVisible()
        window?.rootViewController = UINavigationController(
            rootViewController: EventsBuilder().build()
        )
        
        return true
    }

}

