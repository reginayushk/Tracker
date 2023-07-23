//
//  TrackersViewController.swift
//  Tracker
//
//  Created by Regina Yushkova on 20.06.2023.
//

import UIKit

final class TrackersViewController: UIViewController {
    
    // UI
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .compact
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "ru_RU")
        datePicker.calendar.firstWeekday = 2
        datePicker.tintColor = .ypBlue
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        return datePicker
    }()
    
    private lazy var searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        controller.delegate = self
        controller.searchBar.delegate = self
        controller.hidesNavigationBarDuringPresentation = false
        return controller
    }()
    
    private lazy var trackersCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TrackersCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(TrackersHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        return collectionView
    }()
    
    private lazy var placeholderView = TrackersPlaceholderView()
    
    // MARK: - Private Properties
    
    private var isFiltered: Bool = false
    private var searchText: String = ""
    private let presenter: TrackersPresenterProtocol
    private let trackersCreateAssembly: TrackersCreateAssemblyProtocol
    private var params = GeometricParams(cellCount: 2, leftInset: 16, rightInset: 16, cellSpacing: 9)
    
    // MARK: - Initialize
    
    init(
        presenter: TrackersPresenterProtocol,
        trackersCreateAssembly: TrackersCreateAssemblyProtocol
    ) {
        self.presenter = presenter
        self.trackersCreateAssembly = trackersCreateAssembly
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigationBar()
        setUp()
        
        presenter.fetchTrackerCategories()
        presenter.filterTrackersByDate()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        placeholderView.center = view.center
    }
    
    // MARK: - Private
    
    private func setUpNavigationBar() {
        if let navBar = navigationController?.navigationBar {
            let leftButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewTracker))
            leftButton.tintColor = .ypBlack
            navBar.topItem?.setLeftBarButton(leftButton, animated: false)
            
            let rightButton = UIBarButtonItem(customView: datePicker)
            navBar.topItem?.setRightBarButton(rightButton, animated: false)
        }
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.searchController = searchController

        title = "Трекеры"
    }
    
    private func setUp() {
        view.backgroundColor = .systemBackground
        [trackersCollectionView, placeholderView].forEach { view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            trackersCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            trackersCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            trackersCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trackersCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    // MARK: - Actions
    
    @objc
    private func addNewTracker() {
        let trackersCreateViewController = trackersCreateAssembly.assemble()
        present(trackersCreateViewController, animated: true)
    }
    
    @objc
    private func dateChanged() {
        presenter.update(currentDate: datePicker.date)
        presenter.filterTrackersByDate()
    }
}

// MARK: - UISearchControllerDelegate

extension TrackersViewController: UISearchControllerDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchText = ""
        isFiltered = false
        presenter.reloadVisibleCategories(searchText: nil)
    }
}

// MARK: - UISearchBarDelegate

extension TrackersViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
        isFiltered = true
        presenter.reloadVisibleCategories(searchText: searchText)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension TrackersViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(
            width: (collectionView.bounds.width - params.paddingWidth) / CGFloat(params.cellCount),
            height: 148
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
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        UIEdgeInsets(top: 12, left: params.leftInset, bottom: 0, right: params.rightInset)
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

// MARK: - UICollectionViewDataSource

extension TrackersViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        presenter.numberOfSections()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfItems(numberOfItemsInSection: section)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let trackerCell = trackersCollectionView.dequeueReusableCell(
                withReuseIdentifier: "cell",
                for: indexPath
            ) as? TrackersCollectionViewCell,
            let model = presenter.chooseViewModel(for: indexPath)
        else { return UICollectionViewCell() }

        trackerCell.delegate = self
        trackerCell.configure(with: model)

        let isCompleted = presenter.checkCompletedTrackers(indexPath: indexPath)
        let completedDays = presenter.obtainCompletedDays(indexPath: indexPath)
        trackerCell.setIsCompleted(isCompleted, completedDays)

        return trackerCell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard
            let view = trackersCollectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "header",
                for: indexPath
            ) as? TrackersHeader,
            let model = presenter.chooseViewModelForHeader(at: indexPath)
        else {
            return UICollectionReusableView()
        }

        view.configure(with: model)
        
        return view
    }
}

// MARK: - TrackersCollectionViewCellDelegate

extension TrackersViewController: TrackersCollectionViewCellDelegate {
    func trackersCompletionButtonDidTap(cell: TrackersCollectionViewCell) {
        guard let indexPath = trackersCollectionView.indexPath(for: cell) else { return }
        presenter.setCompletedTrackers(indexPath: indexPath)
        
        trackersCollectionView.reloadItems(at: [indexPath])
    }
}

// MARK: - TrackersViewControllerProtocol

extension TrackersViewController: TrackersViewControllerProtocol {
    
    func reloadCollection() {
        trackersCollectionView.reloadData()
    }
    
    func reloadPlaceholder(model: TrackersPlaceholderViewModel) {
        placeholderView.isHidden = presenter.placeholderShouldBeHidden()
        placeholderView.configure(with: model)
    }
}

// MARK: - TrackerStoreDelegate

extension TrackersViewController: TrackerStoreDelegate {

    func didUpdateTracker() {
        presenter.reloadVisibleCategories(searchText: nil)
    }
}

// MARK: - TrackerCategoryStoreDelegate

extension TrackersViewController: TrackerCategoryStoreDelegate {

    func didUpdateTrackerCategory() {
    }
}

// MARK: - TrackerRecordStoreDelegate

extension TrackersViewController: TrackerRecordStoreDelegate {

    func didUpdateTrackerRecord() {
    }
}
