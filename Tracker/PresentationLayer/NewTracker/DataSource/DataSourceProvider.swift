//
//  DataSourceProvider.swift
//  Tracker
//
//  Created by Regina Yushkova on 05.07.2023.
//

import UIKit

final class DataSourceProvider: DataSourceProviderProtocol {
    
    // MARK: - Public Properties

    let emojies: [NewTrackerEmojiCollectionViewCellModel] = [
        NewTrackerEmojiCollectionViewCellModel(emoji: "🙂"),
        NewTrackerEmojiCollectionViewCellModel(emoji: "😻"),
        NewTrackerEmojiCollectionViewCellModel(emoji: "🌺"),
        NewTrackerEmojiCollectionViewCellModel(emoji: "🐶"),
        NewTrackerEmojiCollectionViewCellModel(emoji: "❤️"),
        NewTrackerEmojiCollectionViewCellModel(emoji: "😱"),
        NewTrackerEmojiCollectionViewCellModel(emoji: "😇"),
        NewTrackerEmojiCollectionViewCellModel(emoji: "😡"),
        NewTrackerEmojiCollectionViewCellModel(emoji: "🥶"),
        NewTrackerEmojiCollectionViewCellModel(emoji: "🤔"),
        NewTrackerEmojiCollectionViewCellModel(emoji: "🙌"),
        NewTrackerEmojiCollectionViewCellModel(emoji: "🍔"),
        NewTrackerEmojiCollectionViewCellModel(emoji: "🥦"),
        NewTrackerEmojiCollectionViewCellModel(emoji: "🏓"),
        NewTrackerEmojiCollectionViewCellModel(emoji: "🥇"),
        NewTrackerEmojiCollectionViewCellModel(emoji: "🎸"),
        NewTrackerEmojiCollectionViewCellModel(emoji: "🏝"),
        NewTrackerEmojiCollectionViewCellModel(emoji: "😪")
    ]
    let colors: [NewTrackerColorCollectionViewCellModel] = [
        NewTrackerColorCollectionViewCellModel(color: .ypColorSection1),
        NewTrackerColorCollectionViewCellModel(color: .ypColorSection2),
        NewTrackerColorCollectionViewCellModel(color: .ypColorSection3),
        NewTrackerColorCollectionViewCellModel(color: .ypColorSection4),
        NewTrackerColorCollectionViewCellModel(color: .ypColorSection5),
        NewTrackerColorCollectionViewCellModel(color: .ypColorSection6),
        NewTrackerColorCollectionViewCellModel(color: .ypColorSection7),
        NewTrackerColorCollectionViewCellModel(color: .ypColorSection8),
        NewTrackerColorCollectionViewCellModel(color: .ypColorSection9),
        NewTrackerColorCollectionViewCellModel(color: .ypColorSection10),
        NewTrackerColorCollectionViewCellModel(color: .ypColorSection11),
        NewTrackerColorCollectionViewCellModel(color: .ypColorSection12),
        NewTrackerColorCollectionViewCellModel(color: .ypColorSection13),
        NewTrackerColorCollectionViewCellModel(color: .ypColorSection14),
        NewTrackerColorCollectionViewCellModel(color: .ypColorSection15),
        NewTrackerColorCollectionViewCellModel(color: .ypColorSection16),
        NewTrackerColorCollectionViewCellModel(color: .ypColorSection17),
        NewTrackerColorCollectionViewCellModel(color: .ypColorSection18)
    ]
}
