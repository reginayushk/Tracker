//
//  TrackersPlaceholderView.swift
//  Tracker
//
//  Created by Regina Yushkova on 20.06.2023.
//

import UIKit

final class TrackersPlaceholderView: UIView {
    
    // UI
    private let placeholderImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let placeholderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: .size12, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(placeholderImageView)
        addSubview(placeholderLabel)
        
        NSLayoutConstraint.activate([
            placeholderImageView.heightAnchor.constraint(equalToConstant: 80),
            placeholderImageView.widthAnchor.constraint(equalToConstant: 80),
            placeholderImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            placeholderImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            placeholderLabel.topAnchor.constraint(equalTo: placeholderImageView.bottomAnchor, constant: .margin8),
            placeholderLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
}

// MARK: - ConfigurableViewProtocol

extension TrackersPlaceholderView: ConfigurableViewProtocol {

    typealias ConfigurationModel = TrackersPlaceholderViewModel
    
    func configure(with model: ConfigurationModel) {
        placeholderImageView.image = model.image
        placeholderLabel.text = model.description
    }
}
