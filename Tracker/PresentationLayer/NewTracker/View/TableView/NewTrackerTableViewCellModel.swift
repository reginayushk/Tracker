//
//  NewTrackerTableViewCellModel.swift
//  Tracker
//
//  Created by Regina Yushkova on 28.06.2023.
//

import Foundation

final class NewTrackerTableViewCellModel {
    
    let title: String
    var description: String?
    
    internal init(title: String, description: String? = nil) {
        self.title = title
        self.description = description
    }
}
