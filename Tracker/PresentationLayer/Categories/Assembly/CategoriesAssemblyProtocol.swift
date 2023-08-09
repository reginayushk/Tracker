//
//  CategoriesAssemblyProtocol.swift
//  Tracker
//
//  Created by Regina Yushkova on 28.07.2023.
//

import UIKit

protocol CategoriesAssemblyProtocol {
    func assemble(chosenCategory: TrackerCategory?) -> CategoriesViewControllerObservableOutputProtocol
}
