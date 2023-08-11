//
//  TrackersCreateViewController.swift
//  Tracker
//
//  Created by Regina Yushkova on 23.06.2023.
//

import UIKit

final class TrackersCreateViewController: UIViewController {
    
    // UI
    private lazy var habitButton = YPPrimaryButton()
    private lazy var irregularEventButton = YPPrimaryButton()
    
    // MARK: - Private Properties
    
    private let newTrackerAssembly: NewTrackerAssemblyProtocol
    
    // MARK: - Initialize
    
    init(newTrackerAssembly: NewTrackerAssemblyProtocol) {
        self.newTrackerAssembly = newTrackerAssembly
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        return nil
    }

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        navigationItem.largeTitleDisplayMode = .never
        let trackersCreateTitle = NSLocalizedString(
            "trackersCreate.title",
            comment: "Text displayed on TrackersCreateViewController"
        )
        title = trackersCreateTitle
        setUp()

        let habitButtonText = NSLocalizedString(
            "habitButton.text",
            comment: "Text displayed on TrackersCreateViewController's habitButton"
        )
        habitButton.setTitle(habitButtonText, for: .normal)
        let irregularEventButtonText = NSLocalizedString(
            "irregularEventButton.text",
            comment: "Text displayed on TrackersCreateViewController's irregularEventButton"
        )
        irregularEventButton.setTitle(irregularEventButtonText, for: .normal)

        habitButton.addTarget(
            nil,
            action: #selector(habitButtonDidTap),
            for: .touchUpInside
        )
        irregularEventButton.addTarget(
            nil,
            action: #selector(irregularEventButtonDidTap),
            for: .touchUpInside
        )
    }
    
    // MARK: - Private
    
    private func setUp() {
        view.backgroundColor = .systemBackground
        [habitButton, irregularEventButton].forEach { view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            habitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .margin20),
            habitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.margin20),
            habitButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            irregularEventButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .margin20),
            irregularEventButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.margin20),
            irregularEventButton.topAnchor.constraint(equalTo: habitButton.bottomAnchor, constant: .margin16)
        ])
    }
    
    // MARK: - Actions
    
    @objc
    private func habitButtonDidTap() {
        let newTrackerViewController = newTrackerAssembly.assemble(isRegular: true)
        self.present(newTrackerViewController, animated: true)
    }
    
    @objc
    private func irregularEventButtonDidTap() {
        let newTrackerViewController = newTrackerAssembly.assemble(isRegular: false)
        self.present(newTrackerViewController, animated: true)
    }
}
