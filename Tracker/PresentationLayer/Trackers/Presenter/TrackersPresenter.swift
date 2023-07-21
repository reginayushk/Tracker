//
//  TrackersPresenter.swift
//  Tracker
//
//  Created by Regina Yushkova on 23.06.2023.
//

import UIKit

final class TrackersPresenter {
    
    // Dependencies
    weak var viewController: TrackersViewControllerProtocol?
    private let trackerStore: TrackerStoreProtocol
    private let trackerCategoryStore: TrackerCategoryStoreProtocol
    private let trackerRecordStore: TrackerRecordStoreProtocol
    
    // MARK: - Private Properties

    private var selectedDate: Date = Date()

    // MARK: - Initialize
    
    init(
        viewController: TrackersViewControllerProtocol? = nil,
        trackerStore: TrackerStoreProtocol,
        trackerCategoryStore: TrackerCategoryStoreProtocol,
        trackerRecordStore: TrackerRecordStoreProtocol
    ) {
        self.viewController = viewController
        self.trackerStore = trackerStore
        self.trackerCategoryStore = trackerCategoryStore
        self.trackerRecordStore = trackerRecordStore
    }
    
    // MARK: - Private
    
    private func categoryCoreData(for section: Int) -> TrackerCategoryCoreData? {
        let trackerCoreData = trackerStore.fetchedResultsController
            .sections?[section]
            .objects?.first as? TrackerCoreData
        return trackerCoreData?.trackerCategory
    }
    
    private func categoryCoreData(for indexPath: IndexPath) -> TrackerCategoryCoreData? {
        return categoryCoreData(for: indexPath.section)
    }
    
    private func trackerCoreData(for indexPath: IndexPath) -> TrackerCoreData? {
        return trackerStore.fetchedResultsController
            .sections?[indexPath.section]
            .objects?[indexPath.item] as? TrackerCoreData
    }
    
    private func trackerRecordsCoreData(for indexPath: IndexPath) -> [TrackerRecordCoreData] {
        return trackerCoreData(for: indexPath)?.trackerRecord?.allObjects as? [TrackerRecordCoreData] ?? []
    }
}

extension TrackersPresenter: TrackersPresenterProtocol {
    
    func numberOfSections() -> Int {
        return trackerStore.fetchedResultsController.sections?.count ?? .zero
    }
    
    func numberOfItems(numberOfItemsInSection section: Int) -> Int {
        return trackerStore.fetchedResultsController.sections?[section].numberOfObjects ?? .zero
    }
    
    func placeholderShouldBeHidden() -> Bool {
        let isCategoriesEmpty = trackerStore.fetchedResultsController.sections?.isEmpty ?? true
        return !isCategoriesEmpty
    }
    
    func chooseViewModel(for indexPath: IndexPath) -> Tracker? {
        guard let trackerCoreData = trackerCoreData(for: indexPath) else { return nil }
        return try? Tracker.from(coreDataModel: trackerCoreData)
    }
    
    func chooseViewModelForHeader(at indexPath: IndexPath) -> TrackerCategory? {
        guard let cdModel = categoryCoreData(for: indexPath) else { return nil }
        return try? TrackerCategory.from(coreDataModel: cdModel)
    }

    func setCompletedTrackers(indexPath: IndexPath) {
        let currentDate = Date()
        
        guard currentDate > selectedDate else { return }
                        
        if let cdRecord = trackerRecordsCoreData(for: indexPath).first(
            where: { record in
                guard let cdRecordDate = record.date else { return false }
                return Calendar.current.isDate(cdRecordDate, inSameDayAs: selectedDate)
            }
        ) {
            let record = try! TrackerRecord.from(coreDataModel: cdRecord)
            try! trackerRecordStore.deleteTrackerRecord(record)
            return
        }
        
        guard
            let cdTracker = trackerCoreData(for: indexPath),
            let cdTrackerId = cdTracker.id
        else { return }
        
        let trackerRecord = TrackerRecord(id: cdTrackerId, date: selectedDate)
        let tracker = try! Tracker.from(coreDataModel: cdTracker)
        try! trackerRecordStore.addNewTrackerRecord(trackerRecord, for: tracker)
    }
    
    func checkCompletedTrackers(indexPath: IndexPath) -> Bool {
        let trackerRecordsCoreData = trackerRecordsCoreData(for: indexPath)
        
        return trackerRecordsCoreData.contains { record in
            guard let recordDate = record.date else { return false }
            return Calendar.current.isDate(recordDate, inSameDayAs: selectedDate)
        }
    }
    
    func fetchTrackerCategories() {
        try! trackerStore.fetchedResultsController.performFetch()
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
        
        var predicates: [NSPredicate] = []
        
        let predicateForDate = NSPredicate(
            format: "ANY %K IN %@",
            "repetition.value",
            [filterWeekday]
        )
        predicates.append(predicateForDate)

        if let filterText = searchText?.lowercased(), !filterText.isEmpty {
            let predicateForSearchText = NSPredicate(
                format: "%K CONTAINS[n] %@",
                #keyPath(TrackerCoreData.name),
                filterText
            )
            predicates.append(predicateForSearchText)
        }
        
        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        let fetchedResultsController = trackerStore.fetchedResultsController
        
        fetchedResultsController.fetchRequest.predicate = predicate
        try! fetchedResultsController.performFetch()
        
        viewController?.reloadCollection()
        
        let model = searchText?.isEmpty == false
            ? TrackersPlaceholderViewModel.emptySearchList
            : TrackersPlaceholderViewModel.emptyList

        viewController?.reloadPlaceholder(model: model)
    }
    
    func obtainCompletedDays(indexPath: IndexPath) -> Int {
        return trackerRecordsCoreData(for: indexPath).count
    }
}
