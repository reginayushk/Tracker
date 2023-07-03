//
//  DIStorageProtocol.swift
//  Tracker
//
//  Created by Regina Yushkova on 30.06.2023.
//

import Foundation

protocol DIStorageProtocol {
    var timetableAssembly: TimetableAssemblyProtocol { get }
    var newTrackerAssembly: NewTrackerAssemblyProtocol { get }
    var trackersCreateAssembly: TrackersCreateAssemblyProtocol { get }
    var trackersAssembly: TrackersAssemblyProtocol { get }
}
