//
//  TrackersCollectionViewCell.swift
//  Tracker
//
//  Created by Regina Yushkova on 20.06.2023.
//

import UIKit

private extension CGFloat {
    static let trackerCompletionButtonWidth: CGFloat = 34
}

final class TrackersCollectionViewCell: UICollectionViewCell {

    // UI
    private let trackerContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = .cornerRadius16
        view.layer.masksToBounds = true
        return view
    }()
    
    private let trackerEmojiLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = .cornerRadius12
        label.font = .systemFont(ofSize: .size12, weight: .regular)
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.backgroundColor = .ypWhite
        return label
    }()
    
    private let trackerNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: .size12, weight: .medium)
        return label
    }()
    
    private let trackerCompletionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = .margin8
        return stackView
    }()
    
    private let trackerRepetitionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: .size12, weight: .medium)
        return label
    }()
    
    private lazy var trackerCompletionButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = .cornerRadius17
        button.layer.masksToBounds = true
        button.tintColor = .white
        button.addTarget(self, action: #selector(trackerCompletionButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    // Dependencies
    weak var delegate: TrackersCollectionViewCellDelegate?
    
    // MARK: - Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(trackerContentView)
        [trackerEmojiLabel, trackerNameLabel].forEach { trackerContentView.addSubview($0) }
        addSubview(trackerCompletionStackView)
        [trackerRepetitionLabel, trackerCompletionButton].forEach { trackerCompletionStackView.addArrangedSubview($0) }
        
        NSLayoutConstraint.activate([
            trackerContentView.topAnchor.constraint(equalTo: topAnchor),
            trackerContentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            trackerContentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            trackerContentView.heightAnchor.constraint(equalToConstant: 90)
        ])
        
        NSLayoutConstraint.activate([
            trackerEmojiLabel.widthAnchor.constraint(equalToConstant: .margin24),
            trackerEmojiLabel.heightAnchor.constraint(equalToConstant: .margin24),
            trackerEmojiLabel.topAnchor.constraint(equalTo: trackerContentView.topAnchor, constant: .margin12),
            trackerEmojiLabel.leadingAnchor.constraint(equalTo: trackerContentView.leadingAnchor, constant: .margin12)
        ])
        
        NSLayoutConstraint.activate([
            trackerNameLabel.leadingAnchor.constraint(equalTo: trackerEmojiLabel.leadingAnchor),
            trackerNameLabel.trailingAnchor.constraint(equalTo: trackerContentView.trailingAnchor, constant: -.margin12),
            trackerNameLabel.bottomAnchor.constraint(equalTo: trackerContentView.bottomAnchor, constant: -.margin12)
        ])
        
        NSLayoutConstraint.activate([
            trackerCompletionStackView.topAnchor.constraint(equalTo: trackerContentView.bottomAnchor, constant: .margin8),
            trackerCompletionStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .margin12),
            trackerCompletionStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.margin12),
            trackerCompletionStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -.margin16)
        ])
        
        NSLayoutConstraint.activate([
            trackerCompletionButton.widthAnchor.constraint(equalToConstant: .trackerCompletionButtonWidth),
            trackerCompletionButton.heightAnchor.constraint(equalToConstant: .trackerCompletionButtonWidth)
        ])
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    // MARK: - Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        trackerContentView.backgroundColor = nil
        trackerEmojiLabel.text = ""
        trackerNameLabel.text = ""
        trackerRepetitionLabel.text = ""
        trackerCompletionButton.backgroundColor = nil
    }
    
    // MARK: - Actions
    
    @objc
    private func trackerCompletionButtonDidTap() {
        delegate?.trackersCompletionButtonDidTap(cell: self)
    }
    
    // MARK: - Public
    
    func setIsCompleted(_ isCompleted: Bool, _ completedDays: Int) {
        let formattedText = formatDayLabel(daysCount: completedDays)
        trackerRepetitionLabel.text = formattedText
        
        if isCompleted {
            trackerCompletionButton.setImage(UIImage(named: "Done"), for: .normal)
            trackerCompletionButton.layer.opacity = 0.3
        } else {
            trackerCompletionButton.setImage(UIImage(systemName: "plus"), for: .normal)
            trackerCompletionButton.layer.opacity = 1
        }
    }
    
    // MARK: - Private
    
    private func formatDayLabel(daysCount: Int) -> String {
        let suffix: String
        
        if daysCount % 10 == 1 && daysCount % 100 != 11 {
            suffix = "день"
        } else if (daysCount % 10 == 2 && daysCount % 100 != 12) ||
                    (daysCount % 10 == 3 && daysCount % 100 != 13) ||
                    (daysCount % 10 == 4 && daysCount % 100 != 14) {
            suffix = "дня"
        } else {
            suffix = "дней"
        }
        
        return "\(daysCount) \(suffix)"
    }
}

// MARK: - ConfigurableViewProtocol

extension TrackersCollectionViewCell: ConfigurableViewProtocol {
    typealias ConfigurationModel = Tracker
    
    func configure(with model: ConfigurationModel) {
        trackerContentView.backgroundColor = model.color
        trackerEmojiLabel.text = model.emoji
        trackerNameLabel.text = model.name
        trackerCompletionButton.backgroundColor = model.color
    }
}
