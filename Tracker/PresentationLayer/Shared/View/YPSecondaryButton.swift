//
//  YPSecondaryButton.swift
//  Tracker
//
//  Created by Regina Yushkova on 26.06.2023.
//

import UIKit

private extension CGFloat {
    static let secondaryButtonHeight: CGFloat = 60
}

final class YPSecondaryButton: UIButton {

    // MARK: - Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = .margin16
        layer.borderColor = UIColor.ypRed.cgColor
        layer.borderWidth = 1
        backgroundColor = .systemBackground
        titleLabel?.font = UIFont.systemFont(ofSize: .size16, weight: .medium)

        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: .secondaryButtonHeight)
        ])
    }

    required init?(coder: NSCoder) {
        return nil
    }
}
