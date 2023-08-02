//
//  CategoriesViewModel.swift
//  Tracker
//
//  Created by Regina Yushkova on 28.07.2023.
//

import Foundation

final class CategoriesViewModel {

    // Dependencies
    private(set) lazy var observableTrackerCategories: Observable<[TrackerCategory]> = Observable(wrappedValue: [])
    private(set) var observableSelectedTrackerCategory: Observable<TrackerCategory?>
    
    private let trackerCategoryStore: TrackerCategoryStoreProtocol
    weak var viewController: CategoriesViewControllerProtocol?
    
    // MARK: - Private Properties
    
    private var newCategoryObservationStore: Observable<TrackerCategory?>?
    
    // MARK: - Initialize

    init(
        viewController: CategoriesViewControllerProtocol? = nil,
        trackerCategoryStore: TrackerCategoryStoreProtocol,
        observableSelectedTrackerCategory: Observable<TrackerCategory?>
    ) {
        self.viewController = viewController
        self.trackerCategoryStore = trackerCategoryStore
        self.observableSelectedTrackerCategory = observableSelectedTrackerCategory
    }
}

// MARK: - CategoriesViewModelProtocol

extension CategoriesViewModel: CategoriesViewModelProtocol {    
        
    func reloadVisibleCategories() {
        let fetchedCategories = try? trackerCategoryStore.fetchCategories()
        observableTrackerCategories.wrappedValue = fetchedCategories ?? []
        
        let model = TrackersPlaceholderViewModel.emptyCategories
        if observableTrackerCategories.wrappedValue.isEmpty {
            viewController?.reloadPlaceholder(model: model)
        } else {
            viewController?.reloadPlaceholder(model: model)
        }
    }
    
    func placeholderShouldBeHidden() -> Bool {
        let isCategoriesEmpty = trackerCategoryStore.fetchedResultsController.fetchedObjects?.isEmpty ?? true
        return !isCategoriesEmpty
    }
    
    func chooseViewModel(for indexPath: IndexPath) -> CategoriesTableViewCellModel {
        let category = observableTrackerCategories.wrappedValue[indexPath.row]
        let model = CategoriesTableViewCellModel(title: category.name)
        return model
    }
    
    func didSelectRowAt(didSelectRowAt indexPath: IndexPath) {
        observableSelectedTrackerCategory.wrappedValue = observableTrackerCategories.wrappedValue[indexPath.item]
    }
    
    func isCategorySelected(for indexPath: IndexPath) -> Bool {
        return observableTrackerCategories.wrappedValue[indexPath.row] == observableSelectedTrackerCategory.wrappedValue
    }
}
