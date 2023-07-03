//
//  UITableViewCell+Extensions.swift
//  Tracker
//
//  Created by Regina Yushkova on 03.07.2023.
//

import UIKit

extension UITableViewCell {
    
    var topSeparator: UIView? {
        subviews.first { $0.frame.minY == 0 && $0.frame.height <= 1 }
    }
    
    var bottomSeparator: UIView? {
        subviews.first { $0.frame.minY >= bounds.maxY - 1 && $0.frame.height <= 1 }
    }
}
