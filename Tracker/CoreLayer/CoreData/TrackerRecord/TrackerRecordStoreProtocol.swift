//
//  TrackerRecordStoreProtocol.swift
//  Tracker
//
//  Created by Regina Yushkova on 18.07.2023.
//

import Foundation

protocol TrackerRecordStoreProtocol: AnyObject {
    func addNewTrackerRecord(_ trackerRecord: TrackerRecord, for tracker: Tracker) throws
    func deleteTrackerRecord(_ trackerRecord: TrackerRecord) throws
}
