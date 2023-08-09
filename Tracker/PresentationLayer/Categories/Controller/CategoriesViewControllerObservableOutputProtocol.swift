//
//  CategoriesViewControllerObservableOutputProtocol.swift
//  Tracker
//
//  Created by Regina Yushkova on 31.07.2023.
//

import UIKit

protocol CategoriesViewControllerObservableOutputProtocol: UIViewController {
    var observableSelectedTrackerCategory: Observable<TrackerCategory?> { get }
}
