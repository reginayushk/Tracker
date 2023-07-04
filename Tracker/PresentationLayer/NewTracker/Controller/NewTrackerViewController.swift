//
//  NewTrackerViewController.swift
//  Tracker
//
//  Created by Regina Yushkova on 24.06.2023.
//

import UIKit

private extension String {
    static let newHabitNameTextFieldPlaceholder = "Введите название трекера"
    static let cancelButtonText = "Отменить"
    static let createButtonText = "Создать"
}

final class NewTrackerViewController: UIViewController {
    
    // UI
    private lazy var newHabitNameTextField: YPTextField = {
        let textField = YPTextField()
        textField.placeholder = .newHabitNameTextFieldPlaceholder
        textField.addTarget(self, action: #selector(newHabitNameTextFieldDidChange(textField:)), for: .editingChanged)
        textField.delegate = self
        return textField
    }()
    
    private lazy var newHabitTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.isScrollEnabled = false
        
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: .zero, left: .margin16, bottom: .zero, right: .margin16)
        
        tableView.layer.cornerRadius = .cornerRadius16
        
        tableView.register(
            NewTrackerTableViewCell.self,
            forCellReuseIdentifier: NewTrackerTableViewCell.reuseIdentifier
        )
        
        tableView.dataSource = self
        tableView.delegate = self
        
        return tableView
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = .margin8
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var cancelButton: YPSecondaryButton = {
        let button = YPSecondaryButton()
        button.setTitle(.cancelButtonText, for: .normal)
        button.setTitleColor(.ypRed, for: .normal)
        button.addTarget(
            self,
            action: #selector(cancelButtonDidTap),
            for: .touchUpInside
        )
        return button
    }()
    
    private lazy var createButton: YPPrimaryButton = {
        let button = YPPrimaryButton()
        button.setTitle(.createButtonText, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.isEnabled = false
        button.layer.opacity = 0.5
        button.addTarget(
            self,
            action: #selector(createButtonDidTap),
            for: .touchUpInside
        )
        return button
    }()
    
    // MARK: - Private Properties

    private let presenter: NewTrackerPresenterProtocol
    
    // MARK: - Initialize
    
    init(presenter: NewTrackerPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        title = presenter.title
        setUp()
    }
    
    // MARK: - Private
    
    private func setUp() {
        view.backgroundColor = .systemBackground
        [newHabitNameTextField, newHabitTableView, buttonStackView].forEach { view.addSubview($0) }
        [cancelButton, createButton].forEach { buttonStackView.addArrangedSubview($0) }
        
        NSLayoutConstraint.activate([
            newHabitNameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: .margin24),
            newHabitNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .margin16),
            newHabitNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.margin16)
        ])
        
        NSLayoutConstraint.activate([
            newHabitTableView.topAnchor.constraint(equalTo: newHabitNameTextField.bottomAnchor, constant: .margin24),
            newHabitTableView.leadingAnchor.constraint(equalTo: newHabitNameTextField.leadingAnchor),
            newHabitTableView.trailingAnchor.constraint(equalTo: newHabitNameTextField.trailingAnchor),
            newHabitTableView.heightAnchor.constraint(equalToConstant: CGFloat(presenter.numberOfRows() * 75))
        ])
        
        NSLayoutConstraint.activate([
            buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .margin20),
            buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.margin20),
            buttonStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // MARK: - Actions
    
    @objc
    private func cancelButtonDidTap() {
        dismiss(animated: true)
    }
    
    @objc
    private func createButtonDidTap() {
        presenter.saveNewTracker()
        presentingViewController?.presentingViewController?.dismiss(animated: true)
    }
    
    @objc
    private func newHabitNameTextFieldDidChange(textField: UITextField) {
        presenter.setTrackerName(text: textField.text)
    }
}

// MARK: - UITableViewDataSource

extension NewTrackerViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: NewTrackerTableViewCell.reuseIdentifier,
                for: indexPath
            ) as? NewTrackerTableViewCell
        else { return UITableViewCell() }
        
        let model = presenter.chooseViewModel(for: indexPath)
        cell.configure(with: model)
        cell.accessoryType = .disclosureIndicator
        cell.backgroundColor = .ypLightGray
        
        if indexPath.row == presenter.numberOfRows() - 1 {
            cell.separatorInset = UIEdgeInsets(top: 0, left: tableView.bounds.size.width, bottom: 0, right: 0)
        }


        return cell
    }
}

// MARK: - UITableViewDelegate

extension NewTrackerViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRowAt(didSelectRowAt: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - TimetableViewControllerDelegate

extension NewTrackerViewController: TimetableViewControllerDelegate {

    func doneButtonDidTap(chosenTimetable: Set<WeekDay>) {
        presenter.weekDaysDidReceive(chosenTimetable: chosenTimetable)
    }
}

// MARK: - NewTrackerViewControllerProtocol

extension NewTrackerViewController: NewTrackerViewControllerProtocol {
    func reloadCell(at indexPath: IndexPath) {
        newHabitTableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func setCreateButtonEnabled(isEnabled: Bool) {
        createButton.isEnabled = isEnabled
        if isEnabled {
            createButton.layer.opacity = 1
        }
    }
}

// MARK: - UITextFieldDelegate

extension NewTrackerViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
