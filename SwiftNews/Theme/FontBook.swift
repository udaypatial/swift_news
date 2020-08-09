//
//  SFFontBook.swift
//  TravelerWhitelabel
//
//  Created by Uday Patial on 2019-08-06.
//  Copyright © 2019 Uday Patial. All rights reserved.
//

import UIKit

struct FontBook {
    
    enum Style: String, CaseIterable {
        case bold = "Bold"
        case light = "Light"
        case regular = ""
        case medium = "Medium"
        case semiBold = "Condensed Bold"
    }
    
    enum FontFamily: CaseIterable {
        case titleFont
        case textFont
        
        fileprivate var fontFamilyString: String {
            switch self {
            case .titleFont:
                return titleFontFamily ?? "HelveticaNeue"
            case .textFont:
                return textFontFamily ?? "HelveticaNeue"
            }
        }
    }
    
    static var titleFontFamily: String? {
        didSet {
            GLTheme.shared().checkFontAvailibility()
        }
    }
    static var textFontFamily: String? {
        didSet {
            GLTheme.shared().checkFontAvailibility()
        }
    }
    
    static func font(_ fontFamily: FontFamily, _ style: Style = .regular, size: CGFloat) -> UIFont {
        let fontFamilyString = fontFamily.fontFamilyString
        if let font = UIFont(name: fontFamilyString + " " + style.rawValue, size: size) {
            return font
        } else {
            return UIFont(name: "HelveticaNeue", size: size)!
        }
    }
}
