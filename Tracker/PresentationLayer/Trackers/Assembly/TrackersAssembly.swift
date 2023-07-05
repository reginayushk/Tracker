//
//  TrackersAssembly.swift
//  Tracker
//
//  Created by Regina Yushkova on 23.06.2023.
//

import UIKit

final class TrackersAssembly: TrackersAssemblyProtocol {
    
    // Dependencies
    private let dependencies: DIStorageProtocol
    
    // MARK: - Initialize
    
    init(dependencies: DIStorageProtocol) {
        self.dependencies = dependencies
    }
    
    // MARK: - TrackersAssemblyProtocol
    
    func assemble() -> UIViewController {
        let presenter = TrackersPresenter()
        
        let controller = TrackersViewController(
            presenter: presenter,
            trackersCreateAssembly: dependencies.trackersCreateAssembly
        )
        
        presenter.viewController = controller

        return controller
    }
}
