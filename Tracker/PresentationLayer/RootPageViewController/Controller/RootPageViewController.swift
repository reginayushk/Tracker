//
//  RootPageViewController.swift
//  Tracker
//
//  Created by Regina Yushkova on 25.07.2023.
//

import UIKit

final class RootPageViewController: UIPageViewController {
    
    // MARK: - Nested types
    
    private enum Constants {
        static let onboardingButtonText: String = "Вот это технологии!"
        static let onboardingLabelTextFirstPage: String = "Отслеживайте только то, что хотите"
        static let onboardingLabelTextSecondPage: String = "Даже если это не литры воды и йога"
    }

    // UI
    private lazy var pages: [UIViewController] = {
        let firstOnboarding = OnboardingPageViewController()
        let firstModel = OnboardingPageModel(
            image: UIImage(named: "onboarding") ?? UIImage(),
            text: Constants.onboardingLabelTextFirstPage
        )
        firstOnboarding.configure(with: firstModel)

        let secondOnboarding = OnboardingPageViewController()
        let secondModel = OnboardingPageModel(
            image: UIImage(named: "onboarding2") ?? UIImage(),
            text: Constants.onboardingLabelTextSecondPage
        )
        secondOnboarding.configure(with: secondModel)
        
        return [firstOnboarding, secondOnboarding]
    }()
    
    private lazy var onboardingPageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = .ypBlack
        pageControl.currentPage = 0
        pageControl.numberOfPages = pages.count
        pageControl.pageIndicatorTintColor = .ypBlack.withAlphaComponent(0.3)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    private lazy var onboardingButton: YPPrimaryButton = {
        let button = YPPrimaryButton()
        button.setTitle(Constants.onboardingButtonText, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(
            self,
            action: #selector(onboardingButtonDidTap),
            for: .touchUpInside
        )
        return button
    }()
    
    // Dependencies
    private let presenter: RootPagePresenterProtocol

    // MARK: - Initialize
    
    init(presenter: RootPagePresenterProtocol) {
        self.presenter = presenter
        super.init(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal
        )
    }

    @available(*, unavailable, message: "init(coder:) has not been implemented")
    required init?(coder: NSCoder) {
        return nil
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        delegate = self
        
        setUpPageViewController()
        
        if let first = pages.first {
            setViewControllers([first], direction: .forward, animated: true)
        }

        setUpPageViewController()
    }
    
    // MARK: - Private
    
    private func setUpPageViewController() {
        view.backgroundColor = .systemBackground
        [onboardingPageControl, onboardingButton].forEach { view.addSubview($0) }

        NSLayoutConstraint.activate([
            onboardingButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -.margin50),
            onboardingButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .margin20),
            onboardingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.margin20)
        ])
        NSLayoutConstraint.activate([
            onboardingPageControl.bottomAnchor.constraint(equalTo: onboardingButton.topAnchor, constant: -.margin24),
            onboardingPageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    // MARK: - Actions
    
    @objc
    private func onboardingButtonDidTap() {
        presenter.finishOnboarding()
    }
}

// MARK: - UIPageViewControllerDataSource

extension RootPageViewController: UIPageViewControllerDataSource {

    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController
    ) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        return pages[previousIndex]
    }
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController
    ) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        
        guard nextIndex < pages.count else {
            return nil
        }
        
        return pages[nextIndex]
    }
}

// MARK: - UIPageViewControllerDelegate

extension RootPageViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let currentViewController = pageViewController.viewControllers?.first,
           let currentIndex = pages.firstIndex(of: currentViewController) {
            onboardingPageControl.currentPage = currentIndex
        }
    }
}
