//
//  NewTrackerTableViewCell.swift
//  Tracker
//
//  Created by Regina Yushkova on 26.06.2023.
//

import UIKit

final class NewTrackerTableViewCell: UITableViewCell {
    
    // Static
    static let reuseIdentifier = "NewTrackerTableViewCell"
    
    // UI
    let labelVerticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = .margin2
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let titleLabel = UILabel()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .ypGray
        label.isHidden = true
        return label
    }()
    
    // MARK: - Initialize
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(labelVerticalStackView)
        [titleLabel, descriptionLabel].forEach { labelVerticalStackView.addArrangedSubview($0) }
        
        NSLayoutConstraint.activate([
            labelVerticalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .margin16),
            labelVerticalStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        return nil
    }
}

// MARK: - ConfigurableViewProtocol

extension NewTrackerTableViewCell: ConfigurableViewProtocol {

    typealias ConfigurationModel = NewTrackerTableViewCellModel
    
    func configure(with model: ConfigurationModel) {
        titleLabel.text = model.title
        descriptionLabel.text = model.description
        descriptionLabel.isHidden = model.description == nil
    }
}
