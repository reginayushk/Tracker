//
//  NewTrackerColorCollectionViewCell.swift
//  Tracker
//
//  Created by Regina Yushkova on 05.07.2023.
//

import UIKit

private extension CGFloat {
    static let colorCollectionViewViewHeightAnchor: CGFloat = 40
}

final class NewTrackerColorCollectionViewCell: UICollectionViewCell {
    
    // Static
    static let reuseIdentifier = "NewTrackerColorCollectionViewCell"
    
    // UI
    private let colorCollectionViewView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = .cornerRadius8
        return view
    }()
    
    // MARK: - Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = .cornerRadius12
        clipsToBounds = true
        
        addSubview(colorCollectionViewView)
        
        NSLayoutConstraint.activate([
            colorCollectionViewView.centerXAnchor.constraint(equalTo: centerXAnchor),
            colorCollectionViewView.centerYAnchor.constraint(equalTo: centerYAnchor),
            colorCollectionViewView.heightAnchor.constraint(equalToConstant: .colorCollectionViewViewHeightAnchor),
            colorCollectionViewView.widthAnchor.constraint(equalToConstant: .colorCollectionViewViewHeightAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    // MARK: - Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        colorCollectionViewView.backgroundColor = nil
    }
}

// MARK: - ConfigurableViewProtocol

extension NewTrackerColorCollectionViewCell: ConfigurableViewProtocol {
    typealias ConfigurationModel = NewTrackerColorCollectionViewCellModel
    
    func configure(with model: ConfigurationModel) {
        colorCollectionViewView.backgroundColor = model.color
        layer.borderColor = model.color.withAlphaComponent(0.3).cgColor
    }
}
