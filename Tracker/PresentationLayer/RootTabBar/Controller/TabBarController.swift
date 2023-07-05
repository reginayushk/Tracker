//
//  TabBarController.swift
//  Tracker
//
//  Created by Regina Yushkova on 01.07.2023.
//

import UIKit

final class TabBarController: UITabBarController {
    
    // Dependencies
    private(set) lazy var dependenciesStorage: DIStorageProtocol = DIStorage()
    
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
