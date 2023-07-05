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

enum TrackerTimetable: Int, Comparable, CaseIterable {
    case sunday = 1
    case monday 
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    
    var shortLocalization: String {
        switch self {
        case .monday:
            return "Пн"
        case .tuesday:
            return "Вт"
        case .wednesday:
            return "Ср"
        case .thursday:
            return "Чт"
        case .friday:
            return "Пт"
        case .saturday:
            return "Сб"
        case .sunday:
            return "Вс"
        }
    }
    
    static func < (lhs: TrackerTimetable, rhs: TrackerTimetable) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
    
    static func from(_ weekdayModel: WeekDay) -> TrackerTimetable {
        switch weekdayModel {
        case .monday:
            return .monday
        case .tuesday:
            return .tuesday
        case .wednesday:
            return .wednesday
        case .thursday:
            return .thursday
        case .friday:
            return .friday
        case .saturday:
            return .saturday
        case .sunday:
            return .sunday
        }
    }
}
