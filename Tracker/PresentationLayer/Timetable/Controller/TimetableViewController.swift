//
//  TimetableViewController.swift
//  Tracker
//
//  Created by Regina Yushkova on 26.06.2023.
//

import UIKit

final class TimetableViewController: UIViewController {
    
    // UI
    private lazy var timetableTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.isScrollEnabled = false

        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: .zero, left: .margin16, bottom: .zero, right: .margin16)
        tableView.layer.cornerRadius = .cornerRadius16

        tableView.register(
            TimetableTableViewCell.self,
            forCellReuseIdentifier: TimetableTableViewCell.reuseIdentifier
        )
        
        tableView.dataSource = self
        tableView.delegate = self
        
        return tableView
    }()
    
    private lazy var doneButton: YPPrimaryButton = {
        let button = YPPrimaryButton()
        let buttonText = NSLocalizedString(
            "timetableDoneButton.text",
            comment: "Text displayed on TimetableViewController's doneButton"
        )
        button.setTitle(buttonText, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(doneButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    // Dependencies
    weak var delegate: TimetableViewControllerDelegate?
    
    // MARK: - Private Properties
    
    private let presenter: TimetablePresenterProtocol
    
    // MARK: - Initialize
    
    init(presenter: TimetablePresenterProtocol) {
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
        let timetableTitle = NSLocalizedString(
            "timetable.title",
            comment: "Text displayed on TimetableViewController"
        )
        title = timetableTitle
        setUpUI()
    }
    
    // MARK: - Private
    
    private func setUpUI() {
        view.backgroundColor = .systemBackground
        [timetableTableView, doneButton].forEach { view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            timetableTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: .margin24),
            timetableTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .margin16),
            timetableTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.margin16),
            timetableTableView.heightAnchor.constraint(equalToConstant: CGFloat(WeekDay.allCases.count * 75))
        ])
        
        NSLayoutConstraint.activate([
            doneButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -.margin16),
            doneButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .margin20),
            doneButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.margin20)
        ])
    }
    
    // MARK: - Actions
    
    @objc
    private func doneButtonDidTap() {
        let chosenTimetable = presenter.chosenTimetable
        delegate?.doneButtonDidTap(chosenTimetable: chosenTimetable)
        dismiss(animated: true)
    }
}

// MARK: - UITableViewDataSource

extension TimetableViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return WeekDay.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let timetableCell = tableView.dequeueReusableCell(
            withIdentifier: TimetableTableViewCell.reuseIdentifier,
            for: indexPath) as? TimetableTableViewCell else {
            return UITableViewCell()
        }
        timetableCell.delegate = self
        timetableCell.backgroundColor = .ypLightGray
        timetableCell.selectionStyle = .none
        
        let model = presenter.chooseViewModel(for: indexPath)
        timetableCell.configure(with: model)
        
        let timetableIsSet = presenter.checkTimetable(indexPath: indexPath)
        timetableCell.timetableSwitcher.isOn = timetableIsSet
        
        if indexPath.row == WeekDay.allCases.count - 1 {
            timetableCell.separatorInset = UIEdgeInsets(
                top: 0,
                left: tableView.bounds.size.width,
                bottom: 0,
                right: 0
            )
        }

        return timetableCell
    }
}

// MARK: - UITableViewDelegate

extension TimetableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}

// MARK: - TimetableTableViewCellDelegate

extension TimetableViewController: TimetableTableViewCellDelegate {

    func timetableSwitcherDidTap(cell: TimetableTableViewCell) {
        guard let indexPath = timetableTableView.indexPath(for: cell) else { return }
        presenter.setTimetable(indexPath: indexPath)
    }
}

// MARK: - TimetableViewControllerProtocol

extension TimetableViewController: TimetableViewControllerProtocol {
    
}
