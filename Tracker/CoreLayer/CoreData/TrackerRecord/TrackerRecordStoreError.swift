//
//  TrackerRecordStoreError.swift
//  Tracker
//
//  Created by Regina Yushkova on 17.07.2023.
//

import Foundation

enum TrackerRecordStoreError: Error {
    case decodingErrorInvalidRecordId
    case decodingErrorInvalidRecordDate
}
