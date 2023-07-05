//
//  TimetablePresenter.swift
//  Tracker
//
//  Created by Regina Yushkova on 28.06.2023.
//

import Foundation

final class TimetablePresenter {
    
    // Dependencies
    weak var viewController: TimetableViewControllerProtocol?
    private(set) var chosenTimetable: Set<WeekDay> = []
    
    // MARK: - Initialize
    
    init(
        viewController: TimetableViewControllerProtocol? = nil,
        chosenTimetable: Set<WeekDay>
    ) {
        self.viewController = viewController
        self.chosenTimetable = chosenTimetable
    }
}

// MARK: - TimetablePresenterProtocol

extension TimetablePresenter: TimetablePresenterProtocol {
    
    func chooseViewModel(for indexPath: IndexPath) -> WeekDay {
        return WeekDay.allCases[indexPath.row]
    }
    
    func setTimetable(indexPath: IndexPath) {
        let timetable = chooseViewModel(for: indexPath)
        
        if let recordDayIndex = chosenTimetable.firstIndex(where: { timetable.rawValue == $0.rawValue }) {
            chosenTimetable.remove(at: recordDayIndex)
        } else {
            chosenTimetable.insert(timetable)
        }
    }
    
    func checkTimetable(indexPath: IndexPath) -> Bool {
        let timetable = chooseViewModel(for: indexPath)
        return chosenTimetable.contains { weekday in
            timetable.rawValue == weekday.rawValue
        }
    }
}
