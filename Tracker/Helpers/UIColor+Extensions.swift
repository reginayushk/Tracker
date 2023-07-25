//
//  UIColor+Extensions.swift
//  Tracker
//
//  Created by Regina Yushkova on 20.06.2023.
//

import UIKit

extension UIColor {
    static var ypBlue: UIColor { UIColor(named: "ypBlue") ?? UIColor.blue }
    static var ypGray: UIColor { UIColor(named: "ypGray") ?? UIColor.gray }
    static var ypLightGray: UIColor { UIColor(named: "ypLightGray") ?? UIColor.lightGray }
    static var ypWhite: UIColor { UIColor(named: "ypWhite") ?? UIColor.white }
    static var ypBlack: UIColor { UIColor(named: "ypBlack") ?? UIColor.black }
    static var ypRed: UIColor { UIColor(named: "ypRed") ?? UIColor.red }
    static var ypColorSection1: UIColor { UIColor(named: "ypColorSection1") ?? UIColor.red }
    static var ypColorSection2: UIColor { UIColor(named: "ypColorSection2") ?? UIColor.orange }
    static var ypColorSection3: UIColor { UIColor(named: "ypColorSection3") ?? UIColor.blue }
    static var ypColorSection4: UIColor { UIColor(named: "ypColorSection4") ?? UIColor.purple }
    static var ypColorSection5: UIColor { UIColor(named: "ypColorSection5") ?? UIColor.green }
    static var ypColorSection6: UIColor { UIColor(named: "ypColorSection6") ?? UIColor.systemPink }
    static var ypColorSection7: UIColor { UIColor(named: "ypColorSection7") ?? UIColor.systemPink }
    static var ypColorSection8: UIColor { UIColor(named: "ypColorSection8") ?? UIColor.blue }
    static var ypColorSection9: UIColor { UIColor(named: "ypColorSection9") ?? UIColor.green }
    static var ypColorSection10: UIColor { UIColor(named: "ypColorSection10") ?? UIColor.blue }
    static var ypColorSection11: UIColor { UIColor(named: "ypColorSection11") ?? UIColor.orange }
    static var ypColorSection12: UIColor { UIColor(named: "ypColorSection12") ?? UIColor.systemPink }
    static var ypColorSection13: UIColor { UIColor(named: "ypColorSection13") ?? UIColor.yellow }
    static var ypColorSection14: UIColor { UIColor(named: "ypColorSection14") ?? UIColor.blue }
    static var ypColorSection15: UIColor { UIColor(named: "ypColorSection15") ?? UIColor.purple }
    static var ypColorSection16: UIColor { UIColor(named: "ypColorSection16") ?? UIColor.purple }
    static var ypColorSection17: UIColor { UIColor(named: "ypColorSection17") ?? UIColor.purple }
    static var ypColorSection18: UIColor { UIColor(named: "ypColorSection18") ?? UIColor.green }
}

extension UIColor {
    var coreImageColor: CIColor {
        return CIColor(color: self)
    }
    var components: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        let color = coreImageColor
        return (color.red, color.green, color.blue, color.alpha)
    }
}
