//
//  ConfigurableViewProtocol.swift
//  Tracker
//
//  Created by Regina Yushkova on 23.06.2023.
//

import Foundation

protocol ConfigurableViewProtocol {
    associatedtype ConfigurationModel
    func configure(with model: ConfigurationModel)
}
