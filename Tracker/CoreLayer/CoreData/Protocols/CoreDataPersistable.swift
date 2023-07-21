//
//  CoreDataPersistable.swift
//  Tracker
//
//  Created by Regina Yushkova on 18.07.2023.
//

import Foundation
import CoreData

protocol CoreDataPersistable {
    
    associatedtype CoreDataModel: NSManagedObject
    
    func coreDataModel(context: NSManagedObjectContext) throws -> CoreDataModel
    
    static func from(coreDataModel: CoreDataModel) throws -> Self
}
