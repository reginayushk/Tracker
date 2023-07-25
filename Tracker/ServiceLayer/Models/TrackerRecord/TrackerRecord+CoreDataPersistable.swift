//
//  TrackerRecord+CoreDataPersistable.swift
//  Tracker
//
//  Created by Regina Yushkova on 18.07.2023.
//

import Foundation
import CoreData

extension TrackerRecord: CoreDataPersistable {

    typealias CoreDataModel = TrackerRecordCoreData
    
    func coreDataModel(context: NSManagedObjectContext) throws -> TrackerRecordCoreData {
        let model = CoreDataModel(context: context)
                
        model.date = date

        return model
    }
    
    static func from(coreDataModel: TrackerRecordCoreData) throws -> TrackerRecord {
        guard let id = coreDataModel.tracker?.id else {
            throw TrackerRecordStoreError.decodingErrorInvalidRecordId
        }
        guard let date = coreDataModel.date else {
            throw TrackerRecordStoreError.decodingErrorInvalidRecordDate
        }
        return TrackerRecord(
            id: id,
            date: date
        )
    }
}
