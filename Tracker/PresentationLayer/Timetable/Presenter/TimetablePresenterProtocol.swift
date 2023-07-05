//
//  TimetablePresenterProtocol.swift
//  Tracker
//
//  Created by Regina Yushkova on 28.06.2023.
//

import Foundation

protocol TimetablePresenterProtocol {
    var chosenTimetable: Set<WeekDay> { get }
    func chooseViewModel(for indexPath: IndexPath) -> WeekDay
    func setTimetable(indexPath: IndexPath)
    func checkTimetable(indexPath: IndexPath) -> Bool
}
