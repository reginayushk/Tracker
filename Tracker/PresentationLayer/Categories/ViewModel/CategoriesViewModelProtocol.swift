//
//  CategoriesViewModelProtocol.swift
//  Tracker
//
//  Created by Regina Yushkova on 28.07.2023.
//

import Foundation

protocol CategoriesViewModelProtocol {
    var observableTrackerCategories: Observable<[TrackerCategory]> { get }
    var observableSelectedTrackerCategory: Observable<TrackerCategory?> { get }
    
    func reloadVisibleCategories()
    func placeholderShouldBeHidden() -> Bool
    func chooseViewModel(for indexPath: IndexPath) -> CategoriesTableViewCellModel
    func didSelectRowAt(didSelectRowAt indexPath: IndexPath)
    func isCategorySelected(for indexPath: IndexPath) -> Bool
}
