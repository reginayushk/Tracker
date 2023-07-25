//
//  AppDelegate.swift
//  Tracker
//
//  Created by Regina Yushkova on 15.06.2023.
//

import UIKit
import CoreData

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    private(set) lazy var dependenciesStorage: DIStorageProtocol = DIStorage()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Tracker")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                print(error)
            }
        }
        return container
    }()

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        initialCoreDataSetUp()
        return true
    }

    // MARK: - UISceneSession Lifecycle

    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        let configuration = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        configuration.storyboard = nil
        configuration.sceneClass = UIWindowScene.self
        configuration.delegateClass = SceneDelegate.self
        return configuration
    }
    
    // MARK: - Private
    
    private func initialCoreDataSetUp() {
        let categoryStore = dependenciesStorage.trackerCategoryStore
        guard
            let categories = try? categoryStore.fetchCategories(),
            categories.isEmpty
        else { return }
        
        let initialCategories = DataManager.shared.categories
        try? initialCategories.forEach { try categoryStore.addNewTrackerCategory($0) }
    }
}

