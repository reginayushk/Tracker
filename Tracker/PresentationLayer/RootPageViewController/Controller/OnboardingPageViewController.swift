//
//  OnboardingPageViewController.swift
//  Tracker
//
//  Created by Regina Yushkova on 26.07.2023.
//

import UIKit

final class OnboardingPageViewController: UIViewController {
    
    // UI
    private lazy var onboardingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var onboardingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: .size32, weight: .bold)
        label.textColor = .ypBlack
        label.numberOfLines = .zero
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        [onboardingImageView, onboardingLabel].forEach { view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            onboardingImageView.topAnchor.constraint(equalTo: view.topAnchor),
            onboardingImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            onboardingImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            onboardingImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            onboardingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .margin16),
            onboardingLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.margin16),
            onboardingLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: .margin64)
        ])
    }
}

// MARK: - ConfigurableViewProtocol

extension OnboardingPageViewController: ConfigurableViewProtocol {
    typealias ConfigurationModel = OnboardingPageModel
    
    func configure(with model: ConfigurationModel) {
        onboardingImageView.image = model.image
        onboardingLabel.text = model.text
    }
}
