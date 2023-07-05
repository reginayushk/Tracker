//
//  TrackersCreateViewController.swift
//  Tracker
//
//  Created by Regina Yushkova on 23.06.2023.
//

import UIKit

private extension String {
    static let habitButtonText = "Привычка"
    static let irregularEventButtonText = "Нерегулярное событие"
}

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
        title = "Создание трекера"
        setUp()

        habitButton.setTitle(.habitButtonText, for: .normal)
        irregularEventButton.setTitle(.irregularEventButtonText, for: .normal)

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
        view.addSubview(habitButton)
        view.addSubview(irregularEventButton)
        
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
