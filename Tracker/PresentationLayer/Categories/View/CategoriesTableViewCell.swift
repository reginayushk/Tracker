//
//  CategoriesTableViewCell.swift
//  Tracker
//
//  Created by Regina Yushkova on 28.07.2023.
//

import UIKit

private extension CGFloat {
    static let checkmarkImageViewWidthAnchor: CGFloat = 24
}

final class CategoriesTableViewCell: UITableViewCell {
    
    // Static
    static let reuseIdentifier = "CategoriesTableViewCell"
    
    // UI
    let horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = .zero
        stackView.axis = .horizontal
        return stackView
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    let checkmarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "checkmark")
        imageView.isHidden = true
        return imageView
    }()
    
    // MARK: - Initialize
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(horizontalStackView)
        [titleLabel, checkmarkImageView].forEach { horizontalStackView.addArrangedSubview($0) }
        
        NSLayoutConstraint.activate([
            horizontalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .margin16),
            horizontalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.margin16),
            horizontalStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            checkmarkImageView.widthAnchor.constraint(equalToConstant: .checkmarkImageViewWidthAnchor),
            checkmarkImageView.heightAnchor.constraint(equalToConstant: .checkmarkImageViewWidthAnchor)
        ])
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        return nil
    }
    
    // MARK: - Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        topSeparator?.isHidden = true
    }
}

// MARK: - ConfigurableViewProtocol

extension CategoriesTableViewCell: ConfigurableViewProtocol {

    typealias ConfigurationModel = CategoriesTableViewCellModel
    
    func configure(with model: ConfigurationModel) {
        titleLabel.text = model.title
    }
}
