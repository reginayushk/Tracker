//
//  RootTabBarAssembly.swift
//  Tracker
//
//  Created by Regina Yushkova on 26.07.2023.
//

import UIKit

final class RootTabBarAssembly: RootTabBarAssemblyProtocol {
    
    // Dependencies
    private let dependencies: DIStorageProtocol
    
    // MARK: - Initialize
    
    init(dependencies: DIStorageProtocol) {
        self.dependencies = dependencies
    }
    
    // MARK: - TrackersCreateAssemblyProtocol
    
    func assemble() -> UIViewController {
        
        let controller = TabBarController(trackersAssembly: dependencies.trackersAssembly)

        return controller
    }
}
