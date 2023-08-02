//
//  AddNewCategoryViewController.swift
//  Tracker
//
//  Created by Regina Yushkova on 30.07.2023.
//

import UIKit

private extension String {
    static let addNewCategoryTextFieldPlaceholder = "Введите название категории"
    static let addNewCategoryActionButtonText = "Готово"
}

final class AddNewCategoryViewController: UIViewController {
    
    // UI
    private lazy var addNewCategoryTextField: YPTextField = {
        let textField = YPTextField()
        textField.placeholder = .addNewCategoryTextFieldPlaceholder
        textField.addTarget(
            self,
            action: #selector(addNewCategoryTextFieldDidChange(textField:)),
            for: .editingChanged
        )
        return textField
    }()
    
    private lazy var addNewCategoryActionButton: YPPrimaryButton = {
        let button = YPPrimaryButton()
        button.setTitle(.addNewCategoryActionButtonText, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(
            self,
            action: #selector(addNewCategoryActionButtonDidTap),
            for: .touchUpInside
        )
        button.isEnabled = false
        button.layer.opacity = 0.5
        return button
    }()
    
    // MARK: - Private Properties
    
    private var viewModel: AddNewCategoryViewModelProtocol
    
    // MARK: - Initialize
    
    init(viewModel: AddNewCategoryViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Новая категория"
        setUp()
    }
    
    // MARK: - Private
    
    private func setUp() {
        view.backgroundColor = .systemBackground
        [addNewCategoryTextField, addNewCategoryActionButton].forEach { view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            addNewCategoryTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: .margin24),
            addNewCategoryTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .margin16),
            addNewCategoryTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.margin16)
        ])
        
        NSLayoutConstraint.activate([
            addNewCategoryActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .margin20),
            addNewCategoryActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.margin20),
            addNewCategoryActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -.margin16)
        ])
    }
    
    // MARK: - Actions
    
    @objc
    private func addNewCategoryTextFieldDidChange(textField: UITextField) {
        viewModel.setTrackerCategory(text: textField.text)
    }
    
    @objc
    private func addNewCategoryActionButtonDidTap() {
        viewModel.saveTrackerCategory()
        dismiss(animated: true)
    }
}

// MARK: - AddNewCategoryViewControllerProtocol

extension AddNewCategoryViewController: AddNewCategoryViewControllerProtocol {
    
    func setAddNewCategoryActionButtonEnabled(isEnabled: Bool) {
        addNewCategoryActionButton.isEnabled = isEnabled
        if isEnabled {
            addNewCategoryActionButton.layer.opacity = 1
        } else {
            addNewCategoryActionButton.layer.opacity = 0.5
        }
    }
}

// MARK: - AddNewCategoryViewControllerObservableOutputProtocol

extension AddNewCategoryViewController: AddNewCategoryViewControllerObservableOutputProtocol {
    
    var observableNewTrackerCategory: Observable<Bool?> {
        return viewModel.observableNewTrackerCategory
    }
}
