//
//  TrackersCollectionViewCellDelegate.swift
//  Tracker
//
//  Created by Regina Yushkova on 23.06.2023.
//

import Foundation

protocol TrackersCollectionViewCellDelegate: AnyObject {
    func trackersCompletionButtonDidTap(cell: TrackersCollectionViewCell)
}
