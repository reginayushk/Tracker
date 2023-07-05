//
//  NewTrackerAssembly.swift
//  Tracker
//
//  Created by Regina Yushkova on 24.06.2023.
//

import UIKit

final class NewTrackerAssembly: NewTrackerAssemblyProtocol {
    
    // Dependencies
    private let dependencies: DIStorageProtocol
    
    // MARK: - Initialize
    
    init(dependencies: DIStorageProtocol) {
        self.dependencies = dependencies
    }
    
    // MARK: - TrackersCreateAssemblyProtocol
    
    func assemble(isRegular: Bool) -> UIViewController {
        let router = NewTrackerRouter(timetableAssembly: dependencies.timetableAssembly)
        
        let presenter = NewTrackerPresenter(
            router: router,
            isRegular: isRegular
        )
        
        let controller = NewTrackerViewController(presenter: presenter)
        
        presenter.viewController = controller
        
        router.transitionHandler = controller
        router.timetableDelegate = controller

        let navigationController = UINavigationController(rootViewController: controller)

        return navigationController
    }
}
