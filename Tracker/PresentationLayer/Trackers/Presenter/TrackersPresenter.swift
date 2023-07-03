//
//  TrackersPresenter.swift
//  Tracker
//
//  Created by Regina Yushkova on 23.06.2023.
//

import Foundation

final class TrackersPresenter {
    
    // Dependencies
    weak var viewController: TrackersViewControllerProtocol?
    private lazy var categories: [TrackerCategory] = dataManager.categories
    private var completedTrackers: Set<TrackerRecord> = []
    private lazy var visibleCategories: [TrackerCategory] = dataManager.categories
    private var selectedDate: Date = Date()
    private let dataManager = DataManager.shared
    
    // MARK: - Initialize
    
    init(
        viewController: TrackersViewControllerProtocol? = nil
    ) {
        self.viewController = viewController
    }
}

extension TrackersPresenter: TrackersPresenterProtocol {
    
    func numberOfSections() -> Int {
        return visibleCategories.count
    }
    
    func numberOfItems(numberOfItemsInSection section: Int) -> Int {
        return visibleCategories[section].trackers.count
    }
    
    func placeholderShouldBeHidden() -> Bool {
        return !visibleCategories.isEmpty
    }
    
    func chooseViewModel(for indexPath: IndexPath) -> Tracker {
        return visibleCategories[indexPath.section].trackers[indexPath.row]
    }
    
    func chooseViewModelForHeader(for indexPath: IndexPath) -> TrackerCategory {
        return visibleCategories[indexPath.section]
    }

    func setCompletedTrackers(indexPath: IndexPath) {
        let tracker = chooseViewModel(for: indexPath)
        let currentDate = Date()
        
        guard currentDate > selectedDate else { return }
        if let recordIndex = completedTrackers.firstIndex(where: { tracker.id == $0.id && Calendar.current.isDate($0.date, inSameDayAs: selectedDate) }) {
            completedTrackers.remove(at: recordIndex)
        } else {
            let trackerRecord = TrackerRecord(id: tracker.id, date: selectedDate)
            completedTrackers.insert(trackerRecord)
        }
    }
    
    func checkCompletedTrackers(indexPath: IndexPath) -> Bool {
        let tracker = chooseViewModel(for: indexPath)
        return completedTrackers.contains { record in
            let isSameDay = Calendar.current.isDate(record.date, inSameDayAs: selectedDate)
            return tracker.id == record.id && isSameDay
        }
    }
    
    func filterTrackersByDate() {
        reloadVisibleCategories(searchText: nil)
    }
    
    func update(currentDate: Date) {
        self.selectedDate = currentDate
    }
    
    func reloadVisibleCategories(searchText: String?) {
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "ru_RU")
        
        let filterWeekday = calendar.component(.weekday, from: selectedDate)
        let filterText = (searchText ?? "").lowercased()
        
        visibleCategories = categories.compactMap({ category in
            let trackers = category.trackers.filter({ tracker in
                let textCondition = filterText.isEmpty ||
                tracker.name.lowercased().contains(filterText)
                let dateCondition = tracker.repetition?.contains(where: { weekday in
                    weekday.rawValue == filterWeekday
                }) == true
                
                return textCondition && dateCondition
            })
            
            if trackers.isEmpty {
                return nil
            }
            
            return TrackerCategory(
                name: category.name,
                trackers: trackers
            )
        })
        
        viewController?.reloadCollection()
        viewController?.reloadPlaceholder()
    }
    
    func obtainCompletedDays(indexPath: IndexPath) -> Int {
        let tracker = chooseViewModel(for: indexPath)
        return completedTrackers.filter { record in
            record.id == tracker.id
        }.count
    }
    
    func trackerDataModelChanged(_ notification: Notification) {
        categories = dataManager.categories
        reloadVisibleCategories(searchText: nil)
    }
}
