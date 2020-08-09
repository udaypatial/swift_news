//
//  NSAttributedString+Extensions.swift
//  TravelerWhitelabel
//
//  Created by Uday Patial on 2019-06-06.
//  Copyright © 2019 Uday Patial. All rights reserved.
//

import UIKit

extension NSAttributedString {

    static func title1(_ string: String, color: UIColor? = nil, alignment: NSTextAlignment = .left) -> NSAttributedString {
        return NSAttributedString(.title1, string, color: color, alignment: alignment)
    }
    
    static func title2(_ string: String, color: UIColor? = nil, alignment: NSTextAlignment = .left) -> NSAttributedString {
        return NSAttributedString(.title2, string, color: color, alignment: alignment)
    }
    
    static func title3(_ string: String, color: UIColor? = nil, alignment: NSTextAlignment = .left) -> NSAttributedString {
        return NSAttributedString(.title3, string, color: color, alignment: alignment)
    }
    
    static func headline(_ string: String, color: UIColor? = nil, alignment: NSTextAlignment = .left) -> NSAttributedString {
        return NSAttributedString(.headline, string, color: color, alignment: alignment)
    }
    
    static func subheading(_ string: String, color: UIColor? = nil, alignment: NSTextAlignment = .left) -> NSAttributedString {
        return NSAttributedString(.subheading, string, color: color, alignment: alignment)
    }
    
    static func footnote(_ string: String, color: UIColor? = nil, alignment: NSTextAlignment = .left) -> NSAttributedString {
        return NSAttributedString(.footnote, string, color: color, alignment: alignment)
    }
    
    static func callout(_ string: String, color: UIColor? = nil, alignment: NSTextAlignment = .left) -> NSAttributedString {
        return NSAttributedString(.callout, string, color: color, alignment: alignment)
    }
    
    static func body(_ string: String, color: UIColor? = nil, alignment: NSTextAlignment = .left) -> NSAttributedString {
        return NSAttributedString(.body, string, color: color, alignment: alignment)
    }
    
    static func caption1(_ string: String, color: UIColor? = nil, alignment: NSTextAlignment = .left) -> NSAttributedString {
        return NSAttributedString(.caption1, string, color: color, alignment: alignment)
    }
    
    static func caption2(_ string: String, color: UIColor? = nil, alignment: NSTextAlignment = .left) -> NSAttributedString {
        return NSAttributedString(.caption2, string, color: color, alignment: alignment)
    }
    
    static func buttonInput(_ string: String, color: UIColor? = nil, alignment: NSTextAlignment = .left) -> NSAttributedString {
        return NSAttributedString(.buttonInput, string, color: color, alignment: alignment)
    }
    
    static func label(_ string: String, color: UIColor? = nil, alignment: NSTextAlignment = .left) -> NSAttributedString {
        return NSAttributedString(.label, string, color: color, alignment: alignment)
    }
}

private extension NSAttributedString {

    // In Figma, final height = lineHeightMultiple * pointSize,
    // In iOS, final height = lineHeightMultiple * font.lineHeight
    // That's why we use the lines below instead of paragraphStyle.lineHeightMultiple
    private convenience init(_ style: GLTheme.FontStyle, _ string: String, color: UIColor?, alignment: NSTextAlignment = .left) {
        let glFont = GLTheme.shared().fontForStyle(style)
        let font = glFont.font
        let lineHeight = glFont.lineHeight * font.pointSize
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = lineHeight
        paragraphStyle.maximumLineHeight = lineHeight
        paragraphStyle.alignment = alignment
        paragraphStyle.lineBreakMode = .byTruncatingTail
        
        var attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.kern: glFont.kern,
            NSAttributedString.Key.font: font,
            NSAttributedString.Key.baselineOffset: (lineHeight - font.lineHeight) / 4.0
        ]
        
        let textColor: UIColor?
        if color == .clear {
            textColor = .clear
        } else {
            textColor = glFont.color ?? color
        }
        attributes[NSAttributedString.Key.foregroundColor] = textColor
        
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        self.init(attributedString: attributedString)
    }
}
