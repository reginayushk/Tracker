//
//  TrackersCreateAssembly.swift
//  Tracker
//
//  Created by Regina Yushkova on 24.06.2023.
//

import UIKit

final class TrackersCreateAssembly: TrackersCreateAssemblyProtocol {
    
    // Dependencies
    private let dependencies: DIStorageProtocol
    
    // MARK: - Initialize
    
    init(dependencies: DIStorageProtocol) {
        self.dependencies = dependencies
    }
    
    // MARK: - TrackersCreateAssemblyProtocol
    
    func assemble() -> UIViewController {
        
        let controller = TrackersCreateViewController(newTrackerAssembly: dependencies.newTrackerAssembly)

        let navigationController = UINavigationController(rootViewController: controller)

        return navigationController
    }
}
