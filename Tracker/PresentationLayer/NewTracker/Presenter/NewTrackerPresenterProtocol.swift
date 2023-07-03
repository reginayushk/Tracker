//
//  NewTrackerPresenterProtocol.swift
//  Tracker
//
//  Created by Regina Yushkova on 28.06.2023.
//

import Foundation

protocol NewTrackerPresenterProtocol {
    var title: String { get }
    func weekDaysDidReceive(chosenTimetable: Set<WeekDay>)
    func numberOfRows() -> Int
    func chooseViewModel(for indexPath: IndexPath) -> NewTrackerTableViewCellModel
    func didSelectRowAt(didSelectRowAt indexPath: IndexPath)
    func setTrackerName(text: String?)
    func saveNewTracker()
}
