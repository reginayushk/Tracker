//
//  DataManager.swift
//  Tracker
//
//  Created by Regina Yushkova on 30.06.2023.
//

import Foundation

final class DataManager {
    
    // Static
    static let shared = DataManager()
    
    var categories: [TrackerCategory] = [
        TrackerCategory(
            name: "Саморазвитие",
            trackers: []
        )
    ]
}
