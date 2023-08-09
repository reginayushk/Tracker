//
//  SceneDelegate.swift
//  Tracker
//
//  Created by Regina Yushkova on 15.06.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    // UI
    var window: UIWindow?
    
    // Dependencies
    lazy var dependenciesStorage: DIStorageProtocol = {
        return (UIApplication.shared.delegate as! AppDelegate).dependenciesStorage
    }()
    
    // MARK: - Lifecycle

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
        
        if (UserDefaults.standard.bool(forKey: "OnboardingDidShow") == false) {
            UserDefaults.standard.set(true, forKey: "OnboardingDidShow")
            let rootPageViewController = dependenciesStorage.rootPageAssembly.assemble(
                window: window
            )
            window.rootViewController = rootPageViewController
            self.window = window
            window.makeKeyAndVisible()
        } else {
            let rootTabBarController = dependenciesStorage.rootTabBarAssembly.assemble()
            window.rootViewController = rootTabBarController
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}
