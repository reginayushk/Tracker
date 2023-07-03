//
//  TimetableAssemblyProtocol.swift
//  Tracker
//
//  Created by Regina Yushkova on 26.06.2023.
//

import UIKit

protocol TimetableAssemblyProtocol {
    func assemble(delegate: TimetableViewControllerDelegate?, chosenTimetable: Set<WeekDay>?) -> UIViewController
}
