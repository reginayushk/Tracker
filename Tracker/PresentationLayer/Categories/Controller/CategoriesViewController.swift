//
//  CategoriesViewController.swift
//  Tracker
//
//  Created by Regina Yushkova on 28.07.2023.
//

import UIKit

final class CategoriesViewController: UIViewController {
    
    // UI
    private lazy var noCategoriesPlaceholderView = TrackersPlaceholderView()
    
    private lazy var addCategoryButton: YPPrimaryButton = {
        let button = YPPrimaryButton()
        let buttonText = NSLocalizedString(
            "categoriesAddCategoryButton.text",
            comment: "Text displayed on CategoriesViewController's addCategoryButton"
        )
        button.setTitle(buttonText, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(
            self,
            action: #selector(addCategoryButtonDidTap),
            for: .touchUpInside
        )
        return button
    }()
    
    private lazy var categoriesTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(
            top: .zero,
            left: .margin16,
            bottom: .zero,
            right: .margin16
        )
        
        tableView.layer.cornerRadius = .cornerRadius16
        
        tableView.register(
            CategoriesTableViewCell.self,
            forCellReuseIdentifier: CategoriesTableViewCell.reuseIdentifier
        )
        
        tableView.dataSource = self
        tableView.delegate = self
        
        return tableView
    }()
    private lazy var categoriesTableViewHeightConstraint: NSLayoutConstraint = {
        return categoriesTableView.heightAnchor.constraint(equalToConstant: .zero)
    }()
    
    // MARK: - Private Properties
    
    private var viewModel: CategoriesViewModelProtocol
    private let addNewCategoryAssembly: AddNewCategoryAssemblyProtocol
    
    // MARK: - Initialize
    
    init(
        viewModel: CategoriesViewModelProtocol,
        addNewCategoryAssembly: AddNewCategoryAssemblyProtocol
    ) {
        self.viewModel = viewModel
        self.addNewCategoryAssembly = addNewCategoryAssembly
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Категория"
        setUpConstraints()

        viewModel.observableTrackerCategories.bind { [weak self] _ in
            self?.updateTableViewHeight()
            self?.categoriesTableView.reloadData()
        }
        
        viewModel.reloadVisibleCategories()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        noCategoriesPlaceholderView.center = view.center
    }
    
    // MARK: - Private
    
    private func setUpConstraints() {
        view.backgroundColor = .systemBackground
        [noCategoriesPlaceholderView, categoriesTableView, addCategoryButton].forEach { view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            categoriesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: .margin24),
            categoriesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .margin16),
            categoriesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.margin16),
            categoriesTableViewHeightConstraint
        ])
        
        NSLayoutConstraint.activate([
            addCategoryButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .margin20),
            addCategoryButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.margin20),
            addCategoryButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -.margin16)
        ])
    }
    
    private func updateTableViewHeight() {
        let numberOfItems = viewModel.observableTrackerCategories.wrappedValue.count
        let newHeight = CGFloat(numberOfItems * 75)
        categoriesTableViewHeightConstraint.constant = newHeight
    }
    
    // MARK: - Actions
    
    @objc
    private func addCategoryButtonDidTap() {
        let addNewCategoryViewController = addNewCategoryAssembly.assemble()
        
        addNewCategoryViewController.observableNewTrackerCategory.bind { [weak self] _ in
            self?.viewModel.reloadVisibleCategories()
        }

        let navigationController = UINavigationController(
            rootViewController: addNewCategoryViewController
        )
        
        self.present(navigationController, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension CategoriesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.observableTrackerCategories.wrappedValue.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: CategoriesTableViewCell.reuseIdentifier,
                for: indexPath
            ) as? CategoriesTableViewCell
        else { return UITableViewCell() }
        
        let model = viewModel.chooseViewModel(for: indexPath)
        cell.configure(with: model)
        cell.backgroundColor = .ypLightGray
        cell.checkmarkImageView.isHidden = !viewModel.isCategorySelected(for: indexPath)
        
        if indexPath.row == viewModel.observableTrackerCategories.wrappedValue.count - 1 {
            cell.separatorInset = UIEdgeInsets(
                top: 0,
                left: tableView.bounds.size.width,
                bottom: 0,
                right: 0
            )
        }
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension CategoriesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRowAt(didSelectRowAt: indexPath)

        let cell = tableView.dequeueReusableCell(
            withIdentifier: CategoriesTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? CategoriesTableViewCell
        cell?.checkmarkImageView.isHidden = false
        
        tableView.deselectRow(at: indexPath, animated: true)

        dismiss(animated: true)
    }
}


// MARK: - CategoriesViewControllerProtocol

extension CategoriesViewController: CategoriesViewControllerProtocol {

    func reloadPlaceholder(model: TrackersPlaceholderViewModel) {
        noCategoriesPlaceholderView.isHidden = viewModel.placeholderShouldBeHidden()
        noCategoriesPlaceholderView.configure(with: model)
    }
}

// MARK: - CategoriesViewControllerObservableOutputProtocol

extension CategoriesViewController: CategoriesViewControllerObservableOutputProtocol {
    
    var observableSelectedTrackerCategory: Observable<TrackerCategory?> {
        return viewModel.observableSelectedTrackerCategory
    }
}
