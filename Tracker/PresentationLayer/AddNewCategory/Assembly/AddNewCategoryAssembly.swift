//
//  AddNewCategoryAssembly.swift
//  Tracker
//
//  Created by Regina Yushkova on 31.07.2023.
//

import UIKit

final class AddNewCategoryAssembly: AddNewCategoryAssemblyProtocol {
    
    // Dependencies
    private let dependencies: DIStorageProtocol
    
    // MARK: - Initialize
    
    init(dependencies: DIStorageProtocol) {
        self.dependencies = dependencies
    }
    
    // MARK: - AddNewCategoryAssemblyProtocol
    
    func assemble() -> AddNewCategoryViewControllerObservableOutputProtocol {
        
        let viewModel = AddNewCategoryViewModel(
            trackerCategoryStore: dependencies.trackerCategoryStore,
            observableNewTrackerCategory: Observable(wrappedValue: nil)
        )
        
        let controller = AddNewCategoryViewController(
            viewModel: viewModel
        )
        
        viewModel.viewController = controller
                
        return controller
    }
}
