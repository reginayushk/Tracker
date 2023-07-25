//
//  DataSourceProviderProtocol.swift
//  Tracker
//
//  Created by Regina Yushkova on 05.07.2023.
//

import UIKit

protocol DataSourceProviderProtocol {
    var emojies: [NewTrackerEmojiCollectionViewCellModel] { get }
    var colors: [NewTrackerColorCollectionViewCellModel] { get }
}
