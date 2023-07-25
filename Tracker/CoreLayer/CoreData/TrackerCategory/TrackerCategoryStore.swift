//
//  TrackerCategoryStore.swift
//  Tracker
//
//  Created by Regina Yushkova on 17.07.2023.
//

import UIKit
import CoreData

final class TrackerCategoryStore: NSObject {
    
    // MARK: - Private Properties
    
    private let context: NSManagedObjectContext
    private(set) lazy var fetchedResultsController: NSFetchedResultsController<TrackerCategoryCoreData> = {
        let fetchRequest = NSFetchRequest<TrackerCategoryCoreData>(
            entityName: "TrackerCategoryCoreData"
        )
        
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(
                key: "name",
                ascending: false
            )
        ]
        
        let fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: context,
            sectionNameKeyPath: #keyPath(TrackerCategoryCoreData.name),
            cacheName: nil
        )
        
        fetchedResultsController.delegate = self
        try? fetchedResultsController.performFetch()
        
        return fetchedResultsController
    }()
    
    // Dependencies
    weak var delegate: TrackerCategoryStoreDelegate?
    
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

// MARK: - TrackerCategoryStoreProtocol

extension TrackerCategoryStore: TrackerCategoryStoreProtocol {
    
    func fetchCategories() throws -> [TrackerCategory] {
        let fetchRequest = TrackerCategoryCoreData.fetchRequest()
        let trackerCategoryFromCoreData = try context.fetch(fetchRequest)
        return try trackerCategoryFromCoreData.map { try TrackerCategory.from(coreDataModel: $0) }
    }
    
    func addNewTrackerCategory(_ trackerCategory: TrackerCategory) throws {
        _ = try trackerCategory.coreDataModel(context: context)
        try context.save()
    }
}

// MARK: - NSFetchedResultsControllerDelegate

extension TrackerCategoryStore: NSFetchedResultsControllerDelegate {

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        delegate?.didUpdateTrackerCategory()
    }
}
