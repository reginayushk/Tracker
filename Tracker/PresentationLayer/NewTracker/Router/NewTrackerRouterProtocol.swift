//
//  NewTrackerRouterProtocol.swift
//  Tracker
//
//  Created by Regina Yushkova on 30.06.2023.
//

import Foundation

protocol NewTrackerRouterProtocol {
    func presentCategory()
    func presentTimetable(chosenTimetable: Set<WeekDay>?)
}
