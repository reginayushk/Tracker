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

private extension CGFloat {
    static let collectionViewHeight: CGFloat = 238
}

final class NewTrackerViewController: UIViewController {
    
    // UI
    private lazy var newHabitScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var newHabitContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var newHabitNameTextField: YPTextField = {
        let textField = YPTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
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
    
    private var commonCollectionView: UICollectionView {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.isScrollEnabled = false
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(
            NewTrackerCollectionViewHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: NewTrackerCollectionViewHeader.reuseIdentifier
        )
        
        return collectionView
    }
    
    private lazy var emojiCollectionView: UICollectionView = {
        let collectionView = commonCollectionView
        
        collectionView.register(
            NewTrackerEmojiCollectionViewCell.self,
            forCellWithReuseIdentifier: NewTrackerEmojiCollectionViewCell.reuseIdentifier
        )
        
        return collectionView
    }()
    
    private lazy var colorCollectionView: UICollectionView = {
        let collectionView = commonCollectionView
        
        collectionView.register(
            NewTrackerColorCollectionViewCell.self,
            forCellWithReuseIdentifier: NewTrackerColorCollectionViewCell.reuseIdentifier
        )
        
        return collectionView
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
    private var params = GeometricParams(cellCount: 6, leftInset: 16, rightInset: 16, cellSpacing: 6)
    
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
        
        view.addSubview(newHabitScrollView)
        newHabitScrollView.addSubview(newHabitContentView)
        
        [
            newHabitNameTextField,
            newHabitTableView,
            emojiCollectionView,
            colorCollectionView,
            buttonStackView
        ].forEach { newHabitContentView.addSubview($0) }
        
        [
            cancelButton,
            createButton
        ].forEach { buttonStackView.addArrangedSubview($0) }
        
        NSLayoutConstraint.activate([
            newHabitScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            newHabitScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newHabitScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            newHabitScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            newHabitContentView.topAnchor.constraint(equalTo: newHabitScrollView.topAnchor),
            newHabitContentView.leadingAnchor.constraint(equalTo: newHabitScrollView.leadingAnchor),
            newHabitContentView.trailingAnchor.constraint(equalTo: newHabitScrollView.trailingAnchor),
            newHabitContentView.bottomAnchor.constraint(equalTo: newHabitScrollView.bottomAnchor),
            newHabitContentView.widthAnchor.constraint(equalTo: newHabitScrollView.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            newHabitNameTextField.topAnchor.constraint(equalTo: newHabitContentView.topAnchor, constant: .margin24),
            newHabitNameTextField.leadingAnchor.constraint(equalTo: newHabitContentView.leadingAnchor, constant: .margin16),
            newHabitNameTextField.trailingAnchor.constraint(equalTo: newHabitContentView.trailingAnchor, constant: -.margin16)
        ])
        
        NSLayoutConstraint.activate([
            newHabitTableView.topAnchor.constraint(equalTo: newHabitNameTextField.bottomAnchor, constant: .margin24),
            newHabitTableView.leadingAnchor.constraint(equalTo: newHabitNameTextField.leadingAnchor),
            newHabitTableView.trailingAnchor.constraint(equalTo: newHabitNameTextField.trailingAnchor),
            newHabitTableView.heightAnchor.constraint(equalToConstant: CGFloat(presenter.numberOfRows() * 75))
        ])
        
        NSLayoutConstraint.activate([
            emojiCollectionView.topAnchor.constraint(equalTo: newHabitTableView.bottomAnchor, constant: .margin32),
            emojiCollectionView.leadingAnchor.constraint(equalTo: newHabitContentView.leadingAnchor),
            emojiCollectionView.trailingAnchor.constraint(equalTo: newHabitContentView.trailingAnchor),
            emojiCollectionView.heightAnchor.constraint(equalToConstant: .collectionViewHeight)
        ])
        
        NSLayoutConstraint.activate([
            colorCollectionView.topAnchor.constraint(equalTo: emojiCollectionView.bottomAnchor),
            colorCollectionView.leadingAnchor.constraint(equalTo: newHabitContentView.leadingAnchor),
            colorCollectionView.trailingAnchor.constraint(equalTo: newHabitContentView.trailingAnchor),
            colorCollectionView.heightAnchor.constraint(equalToConstant: .collectionViewHeight)
        ])
        
        NSLayoutConstraint.activate([
            buttonStackView.topAnchor.constraint(equalTo: colorCollectionView.bottomAnchor, constant: .margin16),
            buttonStackView.leadingAnchor.constraint(equalTo: newHabitContentView.leadingAnchor, constant: .margin20),
            buttonStackView.trailingAnchor.constraint(equalTo: newHabitContentView.trailingAnchor, constant: -.margin20),
            buttonStackView.bottomAnchor.constraint(equalTo: newHabitContentView.bottomAnchor)
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
        } else {
            createButton.layer.opacity = 0.5
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

// MARK: - UICollectionViewDelegateFlowLayout

extension NewTrackerViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(
            width: (collectionView.bounds.width - params.paddingWidth) / CGFloat(params.cellCount),
            height: 52
        )
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        return params.cellSpacing
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return .zero
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        UIEdgeInsets(top: 24, left: params.leftInset, bottom: 24, right: params.rightInset)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {

        let indexPath = IndexPath(row: 0, section: section)
        let headerView = self.collectionView(collectionView, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader, at: indexPath)
        
        return headerView.systemLayoutSizeFitting(
            CGSize(
                width: collectionView.frame.width,
                height: UIView.layoutFittingExpandedSize.height
            ),
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        )
    }
}

// MARK: - UICollectionViewDelegate

extension NewTrackerViewController: UICollectionViewDelegate {
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        
        switch collectionView {
        case emojiCollectionView:
            let emoji = presenter.chooseViewModelForEmoji(indexPath: indexPath)
            presenter.saveSelectedEmoji(emoji: emoji)
            
            let emojiCell = collectionView.cellForItem(at: indexPath) as? NewTrackerEmojiCollectionViewCell
            emojiCell?.backgroundColor = .ypLightGray
            emojiCell?.clipsToBounds = true
        case colorCollectionView:
            let color = presenter.chooseViewModelForColor(indexPath: indexPath)
            presenter.saveSelectedColor(color: color)
            
            let colorCell = collectionView.cellForItem(at: indexPath) as? NewTrackerColorCollectionViewCell
            colorCell?.layer.borderWidth = 3
        default:
            break
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didDeselectItemAt indexPath: IndexPath
    ) {

        switch collectionView {
        case emojiCollectionView:
            presenter.deleteSelectedEmoji()
            
            let emojiCell = collectionView.cellForItem(at: indexPath) as? NewTrackerEmojiCollectionViewCell
            emojiCell?.backgroundColor = .clear
        case colorCollectionView:
            presenter.deleteSelectedColor()
            
            let colorCell = collectionView.cellForItem(at: indexPath) as? NewTrackerColorCollectionViewCell
            colorCell?.layer.borderWidth = 0
        default:
            break
        }
    }
}

// MARK: - UICollectionViewDataSource

extension NewTrackerViewController: UICollectionViewDataSource {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {

        switch collectionView {
        case emojiCollectionView:
            return presenter.numberOfItemsInEmojiCollectionView()
        case colorCollectionView:
            return presenter.numberOfItemsInColorCollectionView()
        default:
            return .zero
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        switch collectionView {
        case emojiCollectionView:
            guard
                let emojiCell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: NewTrackerEmojiCollectionViewCell.reuseIdentifier,
                    for: indexPath
                ) as? NewTrackerEmojiCollectionViewCell
            else {
                return UICollectionViewCell()
            }
            
            let model = presenter.chooseViewModelForEmoji(indexPath: indexPath)
            emojiCell.configure(with: model)
            
            return emojiCell
        case colorCollectionView:
            guard
                let colorCell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: NewTrackerColorCollectionViewCell.reuseIdentifier,
                    for: indexPath
                ) as? NewTrackerColorCollectionViewCell
            else {
                return UICollectionViewCell()
            }
            
            let model = presenter.chooseViewModelForColor(indexPath: indexPath)
            colorCell.configure(with: model)
            
            return colorCell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        guard
            let view = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: NewTrackerCollectionViewHeader.reuseIdentifier,
                for: indexPath
            ) as? NewTrackerCollectionViewHeader
        else {
            return UICollectionReusableView()
        }
        
        switch collectionView {
        case emojiCollectionView:
            let model = presenter.chooseViewModelForEmojiHeader()
            view.configure(with: model)
        case colorCollectionView:
            let model = presenter.chooseViewModelForColorHeader()
            view.configure(with: model)
        default:
            return UICollectionReusableView()
        }
        
        return view
    }
}
