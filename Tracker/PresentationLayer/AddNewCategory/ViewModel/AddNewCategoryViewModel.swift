//
//  AddNewCategoryViewModel.swift
//  Tracker
//
//  Created by Regina Yushkova on 31.07.2023.
//

import Foundation

final class AddNewCategoryViewModel {
    
    // Dependencies
    weak var viewController: AddNewCategoryViewControllerProtocol?
    private let trackerCategoryStore: TrackerCategoryStoreProtocol
    private(set) var observableNewTrackerCategory: Observable<Bool?>
    
    // MARK: - Private Properties
    
    private lazy var newCategoryName = ""
    
    // MARK: - Initialize

    init(
        viewController: AddNewCategoryViewControllerProtocol? = nil,
        trackerCategoryStore: TrackerCategoryStoreProtocol,
        observableNewTrackerCategory: Observable<Bool?>
    ) {
        self.viewController = viewController
        self.trackerCategoryStore = trackerCategoryStore
        self.observableNewTrackerCategory = observableNewTrackerCategory
    }
}

// MARK: - AddNewCategoryViewModelProtocol

extension AddNewCategoryViewModel: AddNewCategoryViewModelProtocol {
    
    func setTrackerCategory(text: String?) {
        guard let text else { return }
        newCategoryName = text
        toggleCreateButtonIfNeeded(text: text)
    }
    
    func saveTrackerCategory() {
        let newTrackerCategory = TrackerCategory(
            id: UUID(),
            name: newCategoryName,
            trackers: []
        )
        try? trackerCategoryStore.addNewTrackerCategory(newTrackerCategory)
        observableNewTrackerCategory.wrappedValue = true
    }

    // MARK: - Private
    
    private func toggleCreateButtonIfNeeded(text: String?) {
        guard
            let text,
            !text.isEmpty
        else {
            viewController?.setAddNewCategoryActionButtonEnabled(isEnabled: false)
            return
        }
        viewController?.setAddNewCategoryActionButtonEnabled(isEnabled: true)
    }
}
