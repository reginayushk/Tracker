//
//  TabBarController.swift
//  Tracker
//
//  Created by Regina Yushkova on 01.07.2023.
//

import UIKit

final class TabBarController: UITabBarController {
    
    // Dependencies
    private let dependenciesStorage: DIStorageProtocol

    // MARK: - Initialize
    
    init(dependenciesStorage: DIStorageProtocol) {
        self.dependenciesStorage = dependenciesStorage
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable, message: "init(coder:) has not been implemented")
    required init?(coder: NSCoder) {
        return nil
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let trackersViewController = dependenciesStorage.trackersAssembly.assemble()
        let navigationTrackersViewController = UINavigationController(rootViewController: trackersViewController)
        navigationTrackersViewController.tabBarItem = UITabBarItem(
            title: "Трекеры",
            image: UIImage(systemName: "record.circle.fill"),
            selectedImage: nil
        )
        
        let statisticsViewController = StatisticsViewController()
        let navigationStatisticsViewController = UINavigationController(rootViewController: statisticsViewController)
        navigationStatisticsViewController.tabBarItem = UITabBarItem(
            title: "Статистика",
            image: UIImage(systemName: "hare.fill"),
            selectedImage: nil
        )
        
        self.viewControllers = [
            navigationTrackersViewController,
            navigationStatisticsViewController
        ]
    }
}
