//
//  TimetableViewControllerDelegate.swift
//  Tracker
//
//  Created by Regina Yushkova on 28.06.2023.
//

import Foundation

protocol TimetableViewControllerDelegate: AnyObject {
    func doneButtonDidTap(chosenTimetable: Set<WeekDay>)
}
