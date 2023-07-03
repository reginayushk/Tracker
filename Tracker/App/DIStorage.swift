//
//  DIStorage.swift
//  Tracker
//
//  Created by Regina Yushkova on 30.06.2023.
//

import Foundation

final class DIStorage: DIStorageProtocol {

    // MARK: - Presentation

    private(set) lazy var timetableAssembly: TimetableAssemblyProtocol = {
        TimetableAssembly(dependencies: self)
    }()

    private(set) lazy var newTrackerAssembly: NewTrackerAssemblyProtocol = {
        NewTrackerAssembly(dependencies: self)
    }()

    private(set) lazy var trackersCreateAssembly: TrackersCreateAssemblyProtocol = {
        TrackersCreateAssembly(dependencies: self)
    }()

    private(set) lazy var trackersAssembly: TrackersAssemblyProtocol = {
        TrackersAssembly(dependencies: self)
    }()

    // MARK: - Initialize

    init() { }
}
