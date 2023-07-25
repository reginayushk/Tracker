//
//  Tracker.swift
//  Tracker
//
//  Created by Regina Yushkova on 20.06.2023.
//

import UIKit

struct Tracker {
    let id: UUID
    let name: String
    let color: UIColor
    let emoji: String
    let repetition: Set<TrackerTimetable>?
}
