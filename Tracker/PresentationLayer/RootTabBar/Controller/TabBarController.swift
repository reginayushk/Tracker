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
        let trackersTabBarTitle = NSLocalizedString(
            "tabBarTrackers.title",
            comment: "Text displayed on TabBarViewController's trackers"
        )
        navigationTrackersViewController.tabBarItem = UITabBarItem(
            title: trackersTabBarTitle,
            image: UIImage(systemName: "record.circle.fill"),
            selectedImage: nil
        )
        
        let statisticsViewController = StatisticsViewController()
        let navigationStatisticsViewController = UINavigationController(rootViewController: statisticsViewController)
        let staticticsTabBarTitle = NSLocalizedString(
            "tabBarStatictics.title",
            comment: "Text displayed on TabBarViewController's statistics"
        )
        navigationStatisticsViewController.tabBarItem = UITabBarItem(
            title: staticticsTabBarTitle,
            image: UIImage(systemName: "hare.fill"),
            selectedImage: nil
        )
        
        self.viewControllers = [
            navigationTrackersViewController,
            navigationStatisticsViewController
        ]
    }
}
