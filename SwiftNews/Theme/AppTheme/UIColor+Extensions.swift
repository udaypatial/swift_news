//
//  UIColor+Extensions.swift
//  TravelerWhitelabel
//
//  Created by Uday Patial on 2019-06-05.
//  Copyright © 2019 Uday Patial. All rights reserved.
//

import UIKit

extension UIColor {
    static func initWithoutFractions(red: Int, green: Int, blue: Int, alpha: CGFloat = 1) -> UIColor {
        return UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: alpha)
    }
    
    static var bgWhite = UIColor.initWithoutFractions(red: 255, green: 255, blue: 255)
    static var bgLight = UIColor.initWithoutFractions(red: 248, green: 250, blue: 253)
    static var darkSecondary = UIColor.initWithoutFractions(red: 88, green: 98, blue: 113)
    static var darkPrimary = UIColor.initWithoutFractions(red: 5, green: 9, blue: 15)
    static var errorRed = UIColor.initWithoutFractions(red: 253, green: 45, blue: 34)
    static var successGreen = UIColor.initWithoutFractions(red: 118, green: 202, blue: 66)
    static var tertiaryForegroundColor = UIColor.initWithoutFractions(red: 207, green: 213, blue: 224)

    static var secondaryForegroundColor = darkSecondary
    static var primaryForegroundColor = darkPrimary
}
