//
//  TrackerRecordStore.swift
//  Tracker
//
//  Created by Regina Yushkova on 17.07.2023.
//

import UIKit
import CoreData

final class TrackerRecordStore: NSObject {
    
    // MARK: - Private Properties
    
    private let context: NSManagedObjectContext
    
    var fetchedResultsController: NSFetchedResultsController<TrackerRecordCoreData> {
        let fetchRequest = NSFetchRequest<TrackerRecordCoreData>(
            entityName: "TrackerRecordCoreData"
        )
        
        let fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        
        try? fetchedResultsController.performFetch()
        return fetchedResultsController
    }
    
    // Dependencies
    weak var delegate: TrackerRecordStoreDelegate?
    
    // MARK: - Initialize
    
    convenience override init() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.mergePolicy = NSMergePolicy(
            merge: .mergeByPropertyObjectTrumpMergePolicyType
        )
        self.init(context: context)
    }
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
}

// MARK: - TrackerRecordStoreProtocol

extension TrackerRecordStore: TrackerRecordStoreProtocol {
    
//    func fetchRecords() throws -> [TrackerRecord] {
//        let fetchRequest = TrackerRecordCoreData.fetchRequest()
//        let trackerRecordFromCoreData = try context.fetch(fetchRequest)
//        return try trackerRecordFromCoreData.map { try TrackerRecord.from(coreDataModel: $0) }
//    }
    
    func addNewTrackerRecord(_ trackerRecord: TrackerRecord, for tracker: Tracker) throws {
        let trackerFetchRequest = TrackerCoreData.fetchRequest()
        trackerFetchRequest.predicate = NSPredicate(format: "id == %@", tracker.id as CVarArg)
        let trackerCoreData = try context.fetch(trackerFetchRequest).first
        
        let trackerRecordCoreData = try trackerRecord.coreDataModel(context: context)
        trackerRecordCoreData.tracker = trackerCoreData
        
        try context.save()
    }
    
    func deleteTrackerRecord(_ trackerRecord: TrackerRecord) throws {
        let fetchRequest = TrackerRecordCoreData.fetchRequest()
        let idPredicate = NSPredicate(format: "tracker.id = %@", trackerRecord.id as CVarArg)
        let datePredicate = NSPredicate(format: "date = %@", trackerRecord.date as CVarArg)
        fetchRequest.predicate = NSCompoundPredicate(
            andPredicateWithSubpredicates: [
                idPredicate, datePredicate
            ]
        )
        
        guard let record = try context.fetch(fetchRequest).first else { return }
        context.delete(record)
        
        try context.save()
    }
}

// MARK: - NSFetchedResultsControllerDelegate

extension TrackerRecordStore: NSFetchedResultsControllerDelegate {

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        delegate?.didUpdateTrackerRecord()
    }
}
