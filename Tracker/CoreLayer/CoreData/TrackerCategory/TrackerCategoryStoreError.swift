//
//  TrackerCategoryStoreError.swift
//  Tracker
//
//  Created by Regina Yushkova on 17.07.2023.
//

import Foundation

enum TrackerCategoryStoreError: Error {
    case decodingErrorInvalidCategoryId
    case decodingErrorInvalidCategoryName
    case decodingErrorInvalidTrackersInCategory
}
