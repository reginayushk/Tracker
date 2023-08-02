//
//  TrackerCategory+CoreDataPersistable.swift
//  Tracker
//
//  Created by Regina Yushkova on 18.07.2023.
//

import Foundation
import CoreData

extension TrackerCategory: CoreDataPersistable {
    
    typealias CoreDataModel = TrackerCategoryCoreData
    
    func coreDataModel(context: NSManagedObjectContext) throws -> TrackerCategoryCoreData {
        let model = CoreDataModel(context: context)
        
        model.id = id
        model.name = name
        
        let trackers = try trackers.compactMap { try $0.coreDataModel(context: context) }
        model.trackers = NSOrderedSet(array: trackers)
        
        return model
    }
    
    static func from(coreDataModel: TrackerCategoryCoreData) throws -> TrackerCategory {
        guard let id = coreDataModel.id else {
            throw TrackerCategoryStoreError.decodingErrorInvalidCategoryId
        }
        guard let name = coreDataModel.name else {
            throw TrackerCategoryStoreError.decodingErrorInvalidCategoryName
        }
        
        guard let trackersCoreData = coreDataModel.trackers?.array as? [TrackerCoreData] else {
            throw TrackerCategoryStoreError.decodingErrorInvalidTrackersInCategory
        }
        
        let trackers = try trackersCoreData.compactMap {
            try Tracker.from(coreDataModel: $0)
        }
        
        return TrackerCategory(
            id: id,
            name: name,
            trackers: trackers
        )
    }
}
