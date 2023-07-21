//
//  NewTrackerEmojiCollectionViewCell.swift
//  Tracker
//
//  Created by Regina Yushkova on 05.07.2023.
//

import UIKit

final class NewTrackerEmojiCollectionViewCell: UICollectionViewCell {
    
    // Static
    static let reuseIdentifier = "NewTrackerEmojiCollectionViewCell"
    
    // UI
    private let emojiCollectionViewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: .size32)
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = .cornerRadius16
        clipsToBounds = true
        
        addSubview(emojiCollectionViewLabel)
        
        NSLayoutConstraint.activate([
            emojiCollectionViewLabel.topAnchor.constraint(equalTo: topAnchor),
            emojiCollectionViewLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            emojiCollectionViewLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            emojiCollectionViewLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    // MARK: - Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        emojiCollectionViewLabel.text = ""
    }
}

// MARK: - ConfigurableViewProtocol

extension NewTrackerEmojiCollectionViewCell: ConfigurableViewProtocol {
    typealias ConfigurationModel = NewTrackerEmojiCollectionViewCellModel
    
    func configure(with model: ConfigurationModel) {
        emojiCollectionViewLabel.text = model.emoji
    }
}
