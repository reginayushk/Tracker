//
//  TrackersHeader.swift
//  Tracker
//
//  Created by Regina Yushkova on 20.06.2023.
//

import UIKit

final class TrackersHeader: UICollectionReusableView {
    
    // UI
    private let headerLabel = UILabel()
    
    // MARK: - Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(headerLabel)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.font = UIFont.systemFont(ofSize: .size19, weight: .bold)
        
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .margin28),
            headerLabel.topAnchor.constraint(equalTo: topAnchor, constant: .margin16),
            headerLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
}

// MARK: - ConfigurableViewProtocol

extension TrackersHeader: ConfigurableViewProtocol {
    typealias ConfigurationModel = TrackerCategory
    
    func configure(with model: ConfigurationModel) {
        headerLabel.text = model.name
    }
}
