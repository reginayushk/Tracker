//
//  TrackerStoreProtocol.swift
//  Tracker
//
//  Created by Regina Yushkova on 17.07.2023.
//

import Foundation
import CoreData

protocol TrackerStoreProtocol: AnyObject {
    var delegate: TrackerStoreDelegate? { get set }
    var fetchedResultsController: NSFetchedResultsController<TrackerCoreData> { get }
//    func fetchTrackers() throws -> [Tracker]
    func addNewTracker(_ tracker: Tracker, at category: TrackerCategory) throws
}
