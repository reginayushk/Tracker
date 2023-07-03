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
    private lazy var selectedTrackerName: String? = ""
    private lazy var selectedCategory: TrackerCategory? = dataManager.categories.first
    private var sortedTimetable: [TrackerTimetable] = []
    private let dataManager = DataManager.shared
    private let selectedColor: UIColor = .ypColorSection4
    private let selectedEmoji: String = "🐣"
    
    // MARK: - Initialize
    
    init(
        viewController: NewTrackerViewControllerProtocol? = nil,
        router: NewTrackerRouterProtocol,
        isRegular: Bool
    ) {
        self.viewController = viewController
        self.router = router
        self.isRegular = isRegular
    }
}

// MARK: - NewTrackerPresenterProtocol

extension NewTrackerPresenter: NewTrackerPresenterProtocol {

    var title: String {
        return isRegular ? "Новая привычка" : "Новое нерегулярное событие"
    }
    
    func numberOfRows() -> Int {
        return options.count
    }
    
    func chooseViewModel(for indexPath: IndexPath) -> NewTrackerTableViewCellModel {
        return options[indexPath.row]
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
        guard let selectedTrackerName else { return }
        let newTracker = Tracker(
            id: UUID(),
            name: selectedTrackerName,
            color: selectedColor,
            emoji: selectedEmoji,
            repetition: Set(sortedTimetable)
        )
        dataManager.categories[0].trackers.append(newTracker)
        
        NotificationCenter.default.post(
            name: Notification.Name("TrackerDataModelChanged"),
            object: nil,
            userInfo: nil
        )
    }
    
    // MARK: - Private
    
    private func toggleCreateButtonIfNeeded() {
        guard
            let trackerName = selectedTrackerName,
            !trackerName.isEmpty,
            selectedCategory != nil
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
