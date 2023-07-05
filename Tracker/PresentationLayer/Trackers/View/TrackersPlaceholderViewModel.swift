//
//  TrackersPlaceholderViewModel.swift
//  Tracker
//
//  Created by Regina Yushkova on 04.07.2023.
//

import UIKit

final class TrackersPlaceholderViewModel {
    
    let image: UIImage
    let description: String
    
    internal init(image: UIImage, description: String) {
        self.image = image
        self.description = description
    }
    
    static let emptyList = TrackersPlaceholderViewModel(
        image: UIImage(named: "default") ?? UIImage(),
        description: "Что будем отслеживать?"
    )
    
    static let emptySearchList = TrackersPlaceholderViewModel(
        image: UIImage(named: "error") ?? UIImage(),
        description: "Ничего не найдено"
    )
}
