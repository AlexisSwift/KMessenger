//
//  AppDelegate.swift
//  KMessenger
//
//  Created by Alexandra Kondratjeva on 01.11.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    private var rootContainer: UINavigationController = UINavigationController()
    private var appCoordinator: AppCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        rootContainer.isNavigationBarHidden = true
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootContainer
        window?.makeKeyAndVisible()
        appCoordinator = AppCoordinator(router: Router(rootController: rootContainer))
        appCoordinator?.start()
        
        return true
    }
    

}

