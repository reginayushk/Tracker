//
//  TabBarController.swift
//  Tracker
//
//  Created by Regina Yushkova on 01.07.2023.
//

import UIKit

final class TabBarController: UITabBarController {
    
    // MARK: - Private Properties
    
    private let trackersAssembly: TrackersAssemblyProtocol
    
    // MARK: - Initialize
    
    init(trackersAssembly: TrackersAssemblyProtocol) {
        self.trackersAssembly = trackersAssembly
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        return nil
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let trackersViewController = trackersAssembly.assemble()
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
