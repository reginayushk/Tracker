//
//  AddNewCategoryViewModelProtocol.swift
//  Tracker
//
//  Created by Regina Yushkova on 31.07.2023.
//

import Foundation

protocol AddNewCategoryViewModelProtocol {
    var observableNewTrackerCategory: Observable<Bool?> { get }
    
    func setTrackerCategory(text: String?)
    func saveTrackerCategory()
}
