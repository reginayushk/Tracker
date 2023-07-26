//
//  RootPageRouter.swift
//  Tracker
//
//  Created by Regina Yushkova on 26.07.2023.
//

import UIKit

final class RootPageRouter: RootPageRouterProtocol {
    
    // Dependencies
    weak var transitionHandler: UIViewController?
    private let rootTabBarAssembly: RootTabBarAssemblyProtocol
    private let window: UIWindow
    
    // MARK: - Initialize
    
    init(
        transitionHandler: UIViewController? = nil,
        rootTabBarAssembly: RootTabBarAssemblyProtocol,
        window: UIWindow
    ) {
        self.transitionHandler = transitionHandler
        self.rootTabBarAssembly = rootTabBarAssembly
        self.window = window
    }
    
    // MARK: - RootPageRouterProtocol
    
    func finishOnboarding() {
        let rootTabBarController = rootTabBarAssembly.assemble()
        window.rootViewController = rootTabBarController
        window.makeKeyAndVisible()
    }
}
