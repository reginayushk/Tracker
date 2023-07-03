//
//  TrackersPresenterProtocol.swift
//  Tracker
//
//  Created by Regina Yushkova on 23.06.2023.
//

import Foundation

protocol TrackersPresenterProtocol {
    func numberOfSections() -> Int
    func numberOfItems(numberOfItemsInSection section: Int) -> Int
    func chooseViewModel(for indexPath: IndexPath) -> Tracker
    func setCompletedTrackers(indexPath: IndexPath)
    func checkCompletedTrackers(indexPath: IndexPath) -> Bool
    func filterTrackersByDate()
    func reloadVisibleCategories(searchText: String?)
    func update(currentDate: Date)
    func placeholderShouldBeHidden() -> Bool
    func obtainCompletedDays(indexPath: IndexPath) -> Int
    func chooseViewModelForHeader(for indexPath: IndexPath) -> TrackerCategory
    func trackerDataModelChanged(_ notification: Notification)
}
