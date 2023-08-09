//
//  RootPageAssembly.swift
//  Tracker
//
//  Created by Regina Yushkova on 26.07.2023.
//

import UIKit

final class RootPageAssembly: RootPageAssemblyProtocol {
    
    // Dependencies
    private let dependencies: DIStorageProtocol
    
    // MARK: - Initialize
    
    init(dependencies: DIStorageProtocol) {
        self.dependencies = dependencies
    }
    
    // MARK: - RootPageAssemblyProtocol
    
    func assemble(window: UIWindow) -> UIViewController {
        
        let router = RootPageRouter(
            rootTabBarAssembly: dependencies.rootTabBarAssembly,
            window: window
        )
        
        let presenter = RootPagePresenter(router: router)
        
        let controller = RootPageViewController(presenter: presenter)
        
        router.transitionHandler = controller
        
        let navigationController = UINavigationController(rootViewController: controller)

        return navigationController
    }
}
