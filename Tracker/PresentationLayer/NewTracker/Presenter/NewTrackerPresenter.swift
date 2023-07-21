//
//  NewTrackerPresenter.swift
//  Tracker
//
//  Created by Regina Yushkova on 28.06.2023.
//

import UIKit

final class NewTrackerPresenter {
    
    // Dependencies
    weak var viewController: NewTrackerViewControllerProtocol?
    private let router: NewTrackerRouterProtocol
    private let trackerStore: TrackerStoreProtocol
    private let trackerCategoryStore: TrackerCategoryStoreProtocol
    
    // MARK: - Private Properties
    
    private let isRegular: Bool
    private lazy var options: [NewTrackerTableViewCellModel] = {
        var options: [NewTrackerTableViewCellModel] = [
            NewTrackerTableViewCellModel(
                title: "Категория",
                description: selectedCategory?.name
            )
        ]
        if isRegular {
            options.append(
                NewTrackerTableViewCellModel(
                    title: "Расписание",
                    description: nil
                )
            )
        }
        return options
    }()
    private lazy var emojiHeader = NewTrackerCollectionViewHeaderModel(title: "Emoji")
    private lazy var colorHeader = NewTrackerCollectionViewHeaderModel(title: "Цвет")

    private let dataSourceProvider: DataSourceProviderProtocol = DataSourceProvider()

    private var sortedTimetable: [TrackerTimetable] = []
    private lazy var selectedCategory: TrackerCategory? = try? trackerCategoryStore.fetchCategories().first
    private lazy var selectedTrackerName: String? = ""
    private var selectedColor: NewTrackerColorCollectionViewCellModel?
    private var selectedEmoji: NewTrackerEmojiCollectionViewCellModel?
    
    // MARK: - Initialize
    
    init(
        viewController: NewTrackerViewControllerProtocol? = nil,
        router: NewTrackerRouterProtocol,
        isRegular: Bool,
        trackerStore: TrackerStoreProtocol,
        trackerCategoryStore: TrackerCategoryStoreProtocol
    ) {
        self.viewController = viewController
        self.router = router
        self.isRegular = isRegular
        self.trackerStore = trackerStore
        self.trackerCategoryStore = trackerCategoryStore
    }
}

// MARK: - NewTrackerPresenterProtocol

extension NewTrackerPresenter: NewTrackerPresenterProtocol {

    var title: String {
        return isRegular ? "Новая привычка" : "Новое нерегулярное событие"
    }
    
    func numberOfItemsInEmojiCollectionView() -> Int {
        return dataSourceProvider.emojies.count
    }
    
    func numberOfItemsInColorCollectionView() -> Int {
        return dataSourceProvider.colors.count
    }
    
    func numberOfRows() -> Int {
        return options.count
    }
    
    func chooseViewModel(for indexPath: IndexPath) -> NewTrackerTableViewCellModel {
        return options[indexPath.row]
    }
    
    func chooseViewModelForEmojiHeader() -> NewTrackerCollectionViewHeaderModel {
        return emojiHeader
    }
    
    func chooseViewModelForColorHeader() -> NewTrackerCollectionViewHeaderModel {
        return colorHeader
    }
    
    func chooseViewModelForEmoji(indexPath: IndexPath) -> NewTrackerEmojiCollectionViewCellModel {
        return dataSourceProvider.emojies[indexPath.row]
    }
    
    func chooseViewModelForColor(indexPath: IndexPath) -> NewTrackerColorCollectionViewCellModel {
        return dataSourceProvider.colors[indexPath.row]
    }

    func weekDaysDidReceive(chosenTimetable: Set<WeekDay>) {
        let trackerTimetable = chosenTimetable.map(TrackerTimetable.from(_:))
        sortedTimetable = trackerTimetable.sorted(by: <)
        
        var localizedTimetable = ""
        if sortedTimetable.count == TrackerTimetable.allCases.count {
            localizedTimetable = "Каждый день"
        } else {
            let shortLocalizations = sortedTimetable.map { $0.shortLocalization }
            localizedTimetable = shortLocalizations.joined(separator: ", ")
        }

        let indexPath = IndexPath(row: 1, section: 0)
        options[indexPath.row].description = localizedTimetable
        viewController?.reloadCell(at: indexPath)
        toggleCreateButtonIfNeeded()
    }
    
    func didSelectRowAt(didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            router.presentCategory()
        case 1:
            let chosenTimetable = Set(sortedTimetable.map(WeekDay.from(_:)))
            router.presentTimetable(chosenTimetable: chosenTimetable)
        default:
            break
        }
    }
    
    func setTrackerName(text: String?) {
        selectedTrackerName = text
        toggleCreateButtonIfNeeded()
    }
    
    func saveNewTracker() {
        guard
            let selectedTrackerName,
            let selectedCategory,
            let selectedEmoji,
            let selectedColor
        else { return }
        
        let newTracker = Tracker(
            id: UUID(),
            name: selectedTrackerName,
            color: selectedColor.color,
            emoji: selectedEmoji.emoji,
            repetition: Set(sortedTimetable)
        )

        try! trackerStore.addNewTracker(newTracker, at: selectedCategory)
        
//        NotificationCenter.default.post(
//            name: Notification.Name("TrackerDataModelChanged"),
//            object: nil,
//            userInfo: nil
//        )
    }
    
    func saveSelectedEmoji(emoji: NewTrackerEmojiCollectionViewCellModel) {
        self.selectedEmoji = emoji
        toggleCreateButtonIfNeeded()
    }
    
    func saveSelectedColor(color: NewTrackerColorCollectionViewCellModel) {
        self.selectedColor = color
        toggleCreateButtonIfNeeded()
    }
    
    func deleteSelectedEmoji() {
        self.selectedEmoji = nil
    }
    
    func deleteSelectedColor() {
        self.selectedColor = nil
    }
    
    // MARK: - Private
    
    private func toggleCreateButtonIfNeeded() {
        guard
            let trackerName = selectedTrackerName,
            !trackerName.isEmpty,
            selectedCategory != nil,
            selectedEmoji != nil,
            selectedColor != nil
        else {
            viewController?.setCreateButtonEnabled(isEnabled: false)
            return
        }
        if !isRegular || !sortedTimetable.isEmpty {
            viewController?.setCreateButtonEnabled(isEnabled: true)
        } else {
            viewController?.setCreateButtonEnabled(isEnabled: false)
        }
    }
}
