//
//  TrackerCategory.swift
//  Tracker
//
//  Created by Regina Yushkova on 20.06.2023.
//

import Foundation

struct TrackerCategory: Equatable {
    let id: UUID
    let name: String
    let trackers: [Tracker]
}
