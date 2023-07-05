//
//  TrackersViewControllerProtocol.swift
//  Tracker
//
//  Created by Regina Yushkova on 23.06.2023.
//

import Foundation

protocol TrackersViewControllerProtocol: AnyObject {
    func reloadCollection()
    func reloadPlaceholder(model: TrackersPlaceholderViewModel)
}
