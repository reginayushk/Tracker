//
//  AddNewCategoryViewControllerObservableOutputProtocol.swift
//  Tracker
//
//  Created by Regina Yushkova on 01.08.2023.
//

import UIKit

protocol AddNewCategoryViewControllerObservableOutputProtocol: UIViewController {
    var observableNewTrackerCategory: Observable<Bool?> { get }
}
