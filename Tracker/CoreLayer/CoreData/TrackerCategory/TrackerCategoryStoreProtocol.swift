//
//  TrackerCategoryStoreProtocol.swift
//  Tracker
//
//  Created by Regina Yushkova on 17.07.2023.
//

import Foundation
import CoreData

protocol TrackerCategoryStoreProtocol: AnyObject {
 
    var fetchedResultsController: NSFetchedResultsController<TrackerCategoryCoreData> { get }
    
    var delegate: TrackerCategoryStoreDelegate? { get set }
    
    func fetchCategories() throws -> [TrackerCategory]
    func addNewTrackerCategory(_ trackerCategory: TrackerCategory) throws
}
