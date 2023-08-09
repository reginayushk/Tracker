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
    private let categoriesAssembly: CategoriesAssemblyProtocol
    
    // MARK: - Initialize
    
    init(
        transitionHandler: UIViewController? = nil,
        timetableAssembly: TimetableAssemblyProtocol,
        categoriesAssembly: CategoriesAssemblyProtocol
    ) {
        self.transitionHandler = transitionHandler
        self.timetableAssembly = timetableAssembly
        self.categoriesAssembly = categoriesAssembly
    }
    
    // MARK: - NewTrackerRouterProtocol
    
    func presentCategory(chosenCategory: TrackerCategory?) -> Observable<TrackerCategory?> {
        let categoriesViewController = categoriesAssembly.assemble(
            chosenCategory: chosenCategory
        )
        
        let navigationController = UINavigationController(
            rootViewController: categoriesViewController
        )
        
        transitionHandler?.navigationController?.present(
            navigationController,
            animated: true
        )
        
        return categoriesViewController.observableSelectedTrackerCategory
    }
    
    func presentTimetable(chosenTimetable: Set<WeekDay>?) {
        let timetableViewController = timetableAssembly.assemble(
            delegate: timetableDelegate,
            chosenTimetable: chosenTimetable
        )
        transitionHandler?.navigationController?.present(
            timetableViewController,
            animated: true
        )
    }
}
