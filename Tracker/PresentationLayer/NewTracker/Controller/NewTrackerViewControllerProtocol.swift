//
//  NewTrackerViewControllerProtocol.swift
//  Tracker
//
//  Created by Regina Yushkova on 24.06.2023.
//

import Foundation

protocol NewTrackerViewControllerProtocol: AnyObject {
    func reloadCell(at indexPath: IndexPath)
    func setCreateButtonEnabled(isEnabled: Bool)
}
