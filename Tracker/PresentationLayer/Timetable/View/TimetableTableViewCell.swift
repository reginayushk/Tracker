//
//  TimetableTableViewCell.swift
//  Tracker
//
//  Created by Regina Yushkova on 28.06.2023.
//

import UIKit

final class TimetableTableViewCell: UITableViewCell {
    
    // Static
    static let reuseIdentifier = "TimetableTableViewCell"
    
    // UI
    let timetableHorizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = .margin16
        stackView.axis = .horizontal
        return stackView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: .size17, weight: .regular)
        return label
    }()
    
    lazy var timetableSwitcher: UISwitch = {
        let switcher = UISwitch()
        switcher.addTarget(self, action: #selector(timetableSwitcherDidTap), for: .valueChanged)
        switcher.onTintColor = .ypBlue
        return switcher
    }()
    
    // Dependencies
    weak var delegate: TimetableTableViewCellDelegate?
    
    // MARK: - Initialize
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(timetableHorizontalStackView)
        [titleLabel, timetableSwitcher].forEach { timetableHorizontalStackView.addArrangedSubview($0) }
        
        NSLayoutConstraint.activate([
            timetableHorizontalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .margin16),
            timetableHorizontalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.margin16)
        ])
        
        NSLayoutConstraint.activate([
            timetableSwitcher.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .margin22),
            timetableSwitcher.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -.margin22)
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
    
    // MARK: - Actions
    
    @objc
    private func timetableSwitcherDidTap() {
        delegate?.timetableSwitcherDidTap(cell: self)
    }
}

// MARK: - ConfigurableViewProtocol

extension TimetableTableViewCell: ConfigurableViewProtocol {
    typealias ConfigurationModel = WeekDay
    
    func configure(with model: ConfigurationModel) {
        titleLabel.text = "\(model.rawValue)"
    }
}
