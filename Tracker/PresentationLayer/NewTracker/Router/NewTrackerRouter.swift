//
//  NewTrackerRouter.swift
//  Tracker
//
//  Created by Regina Yushkova on 30.06.2023.
//

import UIKit

final class NewTrackerRouter: NewTrackerRouterProtocol {
    
    // Dependencies
    weak var transitionHandler: UIViewController?
    weak var timetableDelegate: TimetableViewControllerDelegate?
    private let timetableAssembly: TimetableAssemblyProtocol
    
    // MARK: - Initialize
    
    init(
        transitionHandler: UIViewController? = nil,
        timetableAssembly: TimetableAssemblyProtocol
    ) {
        self.transitionHandler = transitionHandler
        self.timetableAssembly = timetableAssembly
    }
    
    // MARK: - NewTrackerRouterProtocol
    
    func presentCategory() {
    }
    
    func presentTimetable(chosenTimetable: Set<WeekDay>?) {
        let timetableViewController = timetableAssembly.assemble(
            delegate: timetableDelegate,
            chosenTimetable: chosenTimetable
        )
        transitionHandler?.navigationController?.present(timetableViewController, animated: true)
    }
}
