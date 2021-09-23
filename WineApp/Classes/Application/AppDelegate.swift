//
//  AppDelegate.swift
//  WineApp
//
//  Created by Владислав Бобарыкин on 4.08.21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let coordinator = LoginCoordinator(window: window)
        coordinator.start()
        return true
    }
}

