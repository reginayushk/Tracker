//
//  Tracker+CoreDataPersistable.swift
//  Tracker
//
//  Created by Regina Yushkova on 18.07.2023.
//

import CoreData
import UIKit

extension Tracker: CoreDataPersistable {
    
    typealias CoreDataModel = TrackerCoreData
    
    func coreDataModel(context: NSManagedObjectContext) throws -> TrackerCoreData {
        let model = CoreDataModel(context: context)
        
        model.id = id
        model.name = name
        
        let components = color.coreImageColor
        model.red = Float(components.red)
        model.green = Float(components.green)
        model.blue = Float(components.blue)
        model.alpha = Float(components.alpha)
        
        model.emoji = emoji
        
        if let repetition = try repetition?.map({ try $0.coreDataModel(context: context) }) {
            model.repetition = NSSet(array: repetition)
        }
        
        return model
    }
    
    static func from(coreDataModel: TrackerCoreData) throws -> Tracker {
        guard let id = coreDataModel.id else {
            throw TrackerCastError.decodingErrorInvalidId
        }
        guard let name = coreDataModel.name else {
            throw TrackerCastError.decodingErrorInvalidName
        }
        let color = UIColor(
            red: CGFloat(coreDataModel.red),
            green: CGFloat(coreDataModel.green),
            blue: CGFloat(coreDataModel.blue),
            alpha: CGFloat(coreDataModel.alpha)
        )
        guard let emoji = coreDataModel.emoji else {
            throw TrackerCastError.decodingErrorInvalidEmoji
        }
        
        var repetition: Set<TrackerTimetable>?
        
        if let cdRepetition = coreDataModel.repetition?.allObjects as? [TrackerTimetableCoreData], !cdRepetition.isEmpty {
            let arrayRepetition = try cdRepetition.compactMap { try TrackerTimetable.from(coreDataModel: $0) }
            repetition = Set(arrayRepetition)
        }
        
        return Tracker(
            id: id,
            name: name,
            color: color,
            emoji: emoji,
            repetition: repetition
        )
    }
}
