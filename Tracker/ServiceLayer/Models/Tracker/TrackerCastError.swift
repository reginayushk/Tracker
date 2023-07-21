//
//  TrackerCastError.swift
//  Tracker
//
//  Created by Regina Yushkova on 17.07.2023.
//

import Foundation

enum TrackerCastError: Error {
    case decodingErrorInvalidId
    case decodingErrorInvalidName
    case decodingErrorInvalidEmoji
}
