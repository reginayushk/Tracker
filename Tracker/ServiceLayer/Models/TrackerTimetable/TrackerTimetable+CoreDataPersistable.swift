//
//  TrackerTimetable+CoreDataPersistable.swift
//  Tracker
//
//  Created by Regina Yushkova on 19.07.2023.
//

import Foundation
import CoreData

extension TrackerTimetable: CoreDataPersistable {
    
    typealias CoreDataModel = TrackerTimetableCoreData
    
    func coreDataModel(context: NSManagedObjectContext) throws -> TrackerTimetableCoreData {
        let model = TrackerTimetableCoreData(context: context)
        model.value = Int64(self.rawValue)
        return model
    }
    
    static func from(coreDataModel: TrackerTimetableCoreData) throws -> TrackerTimetable {
        guard
            let trackerTimetable = TrackerTimetable(rawValue: Int(coreDataModel.value))
        else {
            throw TrackerTimeTableCastError.decodingErrorInvalidValue
        }
        return trackerTimetable
    }
}
