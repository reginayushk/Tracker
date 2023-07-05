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
        trackers: [
            Tracker(
                id: UUID(),
                name: "Почитать статьи про ARC",
                color: .ypColorSection1,
                emoji: "🔝",
                repetition: [.saturday, .sunday]
            ),
            Tracker(
                id: UUID(),
                name: "Попрактиковать английский",
                color: .ypColorSection2,
                emoji: "🗣️",
                repetition: [
                    .tuesday,
                    .wednesday,
                    .thursday,
                    .friday,
                    .saturday,
                    .sunday
                ]
            )
        ]
    ),
    TrackerCategory(
        name: "Спорт", trackers: [
            Tracker(
                id: UUID(),
                name: "Позаниматься на велотренажёре",
                color: .ypColorSection3,
                emoji: "🚲",
                repetition: [
                    .tuesday,
                    .thursday,
                    .sunday
                ]
            )
        ])
    ]
}
