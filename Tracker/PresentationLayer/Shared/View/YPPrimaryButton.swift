//
//  YPPrimaryButton.swift
//  Tracker
//
//  Created by Regina Yushkova on 24.06.2023.
//

import UIKit

private extension CGFloat {
    static let primaryButtonHeight: CGFloat = 60
}

final class YPPrimaryButton: UIButton {

    // MARK: - Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = .margin16
        backgroundColor = .ypBlack
        titleLabel?.font = UIFont.systemFont(ofSize: .size16, weight: .medium)

        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: .primaryButtonHeight)
        ])
    }

    required init?(coder: NSCoder) {
        return nil
    }
}
