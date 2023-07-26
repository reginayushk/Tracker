//
//  RootPagePresenter.swift
//  Tracker
//
//  Created by Regina Yushkova on 26.07.2023.
//

import UIKit

final class RootPagePresenter {
    
    // Dependencies
    private let router: RootPageRouterProtocol
    
    // MARK: - Initialize
    
    init(router: RootPageRouterProtocol) {
        self.router = router
    }
}

// MARK: - RootPagePresenterProtocol

extension RootPagePresenter: RootPagePresenterProtocol {
    
    func finishOnboarding() {
        router.finishOnboarding()
    }
}
