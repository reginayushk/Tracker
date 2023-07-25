//
//  NewTrackerPresenterProtocol.swift
//  Tracker
//
//  Created by Regina Yushkova on 28.06.2023.
//

import UIKit

protocol NewTrackerPresenterProtocol {
    var title: String { get }
    func numberOfItemsInEmojiCollectionView() -> Int
    func numberOfItemsInColorCollectionView() -> Int
    func weekDaysDidReceive(chosenTimetable: Set<WeekDay>)
    func numberOfRows() -> Int
    func chooseViewModel(for indexPath: IndexPath) -> NewTrackerTableViewCellModel
    func didSelectRowAt(didSelectRowAt indexPath: IndexPath)
    func setTrackerName(text: String?)
    func saveNewTracker()
    func chooseViewModelForEmoji(indexPath: IndexPath) -> NewTrackerEmojiCollectionViewCellModel
    func chooseViewModelForColor(indexPath: IndexPath) -> NewTrackerColorCollectionViewCellModel
    func saveSelectedEmoji(emoji: NewTrackerEmojiCollectionViewCellModel)
    func saveSelectedColor(color: NewTrackerColorCollectionViewCellModel)
    func deleteSelectedEmoji()
    func deleteSelectedColor()
    func chooseViewModelForEmojiHeader() -> NewTrackerCollectionViewHeaderModel
    func chooseViewModelForColorHeader() -> NewTrackerCollectionViewHeaderModel
}
