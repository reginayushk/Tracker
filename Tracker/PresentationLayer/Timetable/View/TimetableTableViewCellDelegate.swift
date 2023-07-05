//
//  TimetableTableViewCellDelegate.swift
//  Tracker
//
//  Created by Regina Yushkova on 28.06.2023.
//

import Foundation

protocol TimetableTableViewCellDelegate: AnyObject {
    func timetableSwitcherDidTap(cell: TimetableTableViewCell)
}
