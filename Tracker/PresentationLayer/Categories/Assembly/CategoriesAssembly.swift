//
//  CategoriesAssembly.swift
//  Tracker
//
//  Created by Regina Yushkova on 28.07.2023.
//

import UIKit

final class CategoriesAssembly: CategoriesAssemblyProtocol {
    
    // Dependencies
    private let dependencies: DIStorageProtocol
    
    // MARK: - Initialize
    
    init(dependencies: DIStorageProtocol) {
        self.dependencies = dependencies
    }
    
    // MARK: - TrackersCreateAssemblyProtocol
    
    func assemble(chosenCategory: TrackerCategory?) -> CategoriesViewControllerObservableOutputProtocol {
        let viewModel = CategoriesViewModel(
            trackerCategoryStore: dependencies.trackerCategoryStore,
            observableSelectedTrackerCategory: Observable(wrappedValue: chosenCategory)
        )
        
        let controller = CategoriesViewController(
            viewModel: viewModel,
            addNewCategoryAssembly: dependencies.addNewCategoryAssembly
        )
        
        viewModel.viewController = controller
        
        return controller
    }
}
