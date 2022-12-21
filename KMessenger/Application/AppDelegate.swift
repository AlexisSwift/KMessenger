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
        setupNavigationBar()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootContainer
        window?.makeKeyAndVisible()
        appCoordinator = AppCoordinator(router: Router(rootController: rootContainer))
        appCoordinator?.start()
        
        return true
    }
}

// MARK: - Appearance
private extension AppDelegate {
    private func setupNavigationBar() {
        UINavigationBar.appearance().tintColor(.gray)
        UINavigationBar.appearance().barTintColor = .black
        UINavigationBar.appearance().backgroundColor = Palette.backgroundUserProfile
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 20, weight: .bold)
        ]
    }
}
