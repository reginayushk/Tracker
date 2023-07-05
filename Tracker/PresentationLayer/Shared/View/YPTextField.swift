//
//  YPTextField.swift
//  Tracker
//
//  Created by Regina Yushkova on 30.06.2023.
//

import UIKit

private extension CGFloat {
    static let textFieldHeight: CGFloat = 75
    static let textFieldLeadingAnchor: CGFloat = 16
}

final class YPTextField: UITextField {

    // MARK: - Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = .margin16
        backgroundColor = .ypLightGray
        font = UIFont.systemFont(ofSize: .size17)
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: .textFieldLeadingAnchor, height: frame.height))
        leftView = paddingView
        leftViewMode = .always

        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: .textFieldHeight)
        ])
    }

    required init?(coder: NSCoder) {
        return nil
    }
}
