//
//  TimetableAssembly.swift
//  Tracker
//
//  Created by Regina Yushkova on 26.06.2023.
//

import UIKit

final class TimetableAssembly: TimetableAssemblyProtocol {
    
    // Dependencies
    private let dependencies: DIStorageProtocol
    
    // MARK: - Initialize
    
    init(dependencies: DIStorageProtocol) {
        self.dependencies = dependencies
    }
    
    // MARK: - TimetableAssemblyProtocol
    
    func assemble(
        delegate: TimetableViewControllerDelegate?,
        chosenTimetable: Set<WeekDay>?
    ) -> UIViewController {
        let presenter = TimetablePresenter(chosenTimetable: chosenTimetable ?? [])
        
        let controller = TimetableViewController(presenter: presenter)
        controller.delegate = delegate
        
        presenter.viewController = controller

        let navigationController = UINavigationController(rootViewController: controller)

        return navigationController
    }
}
