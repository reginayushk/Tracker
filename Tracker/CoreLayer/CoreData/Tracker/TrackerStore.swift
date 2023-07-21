//
//  TrackerStore.swift
//  Tracker
//
//  Created by Regina Yushkova on 17.07.2023.
//

import UIKit
import CoreData

final class TrackerStore: NSObject {

    // MARK: - Private Properties

    private let context: NSManagedObjectContext
    
    private(set) lazy var fetchedResultsController: NSFetchedResultsController<TrackerCoreData> = {
        let fetchRequest = NSFetchRequest<TrackerCoreData>(
            entityName: "TrackerCoreData"
        )
        
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(
                key: "trackerCategory",
                ascending: false
            )
        ]

        let fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: context,
            sectionNameKeyPath: #keyPath(TrackerCoreData.trackerCategory.name),
            cacheName: nil
        )
        
        fetchedResultsController.delegate = self
        try? fetchedResultsController.performFetch()
        
        return fetchedResultsController
    }()
    
    // Dependencies
    weak var delegate: TrackerStoreDelegate?
    
    // MARK: - Initialize
    
    convenience override init() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.mergePolicy = NSMergePolicy(
            merge: .mergeByPropertyStoreTrumpMergePolicyType
        )
        self.init(context: context)
    }
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
}

// MARK: - TrackerStoreProtocol

extension TrackerStore: TrackerStoreProtocol {

//    func fetchTrackers() throws -> [Tracker] {
//        let fetchRequest = TrackerCoreData.fetchRequest()
//        let trackerFromCoreData = try context.fetch(fetchRequest)
//        return try trackerFromCoreData.map { try Tracker.from(coreDataModel: $0) }
//    }
    
    func addNewTracker(_ tracker: Tracker, at category: TrackerCategory) throws {
        let categoryFetchRequest = TrackerCategoryCoreData.fetchRequest()
        categoryFetchRequest.predicate = NSPredicate(format: "name = %@", category.name)
        let categoryCoreData = try context.fetch(categoryFetchRequest).first
        
        let trackerCoreData = try tracker.coreDataModel(context: context)
        trackerCoreData.trackerCategory = categoryCoreData
        
        try context.save()
    }
}

// MARK: - NSFetchedResultsControllerDelegate

extension TrackerStore: NSFetchedResultsControllerDelegate {

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        delegate?.didUpdateTracker()
    }
}
