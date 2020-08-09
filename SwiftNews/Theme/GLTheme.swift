//
//  GLTheme+Init.swift
//  TravelerWhitelabel
//
//  Created by Uday Patial on 2019-08-06.
//  Copyright © 2019 Uday Patial. All rights reserved.
//

import UIKit

public class GLTheme {
    
    public enum FontStyle: CaseIterable {
        case title1, title2, title3, headline, subheading, footnote, callout, body, caption1, caption2, buttonInput, label
    }
    
    public struct Font {
        public let font: UIFont
        public let kern: CGFloat
        public let lineHeight: CGFloat
        public let color: UIColor?
        
        init(font: UIFont, kern: CGFloat, lineHeight: CGFloat, color: UIColor? = nil) {
            self.font = font
            self.kern = kern
            self.lineHeight = lineHeight
            self.color = color
        }
    }
    
    // MARK: - Public
    
    public var navBarLogoHeight: CGFloat = 36.6
    
    public var brandColor = UIColor.initWithoutFractions(red: 222, green: 1, blue: 8)
    
    public var helpAndFeedbackURL: String?
    public var termsAndConditionsURL: String?
    public var privacyPolicyURL: String?
    
    public var fontForStyle: (_ fontStyle: FontStyle) -> Font {
        get {
            return _fontForStyle
        }
        set {
            checkFontAvailibility(newValue)
            _fontForStyle = newValue
        }
    }
    
    // MARK: - Init

    init() {
        checkFontAvailibility(fontForStyle)
    }
    
    public static func shared() -> GLTheme {
        return _shared
    }
    
    private static var _shared = GLTheme()
    
    // MARK: - Private
    
    private var _fontForStyle: (_ fontStyle: GLTheme.FontStyle) -> Font = { fontStyle in
        switch fontStyle {
        case .title1:
            return Font(font: FontBook.font(.titleFont, .bold, size: 34),
                          kern: 0.41,
                          lineHeight: 1.2)
        case .title2:
            return Font(font: FontBook.font(.titleFont, .bold, size: 22),
                          kern: 0.36,
                          lineHeight: 1.15)
        case .title3:
            return Font(font: FontBook.font(.titleFont, .bold, size: 20),
                          kern: 0.38,
                          lineHeight: 1.2)
        case .headline:
            return Font(font: FontBook.font(.textFont, .semiBold, size: 17),
                          kern: -0.41,
                          lineHeight: 1.5)
        case .subheading:
            return Font(font: FontBook.font(.textFont, .medium, size: 15),
                          kern: -0.24,
                          lineHeight: 1.35)
        case .footnote:
            return Font(font: FontBook.font(.textFont, size: 13),
                          kern: -0.08,
                          lineHeight: 1.4)
        case .callout:
            return Font(font: FontBook.font(.textFont, size: 17),
                          kern: -0.41,
                          lineHeight: 1.3)
        case .body:
            return Font(font: FontBook.font(.textFont, size: 15),
                          kern: -0.24,
                          lineHeight: 1.5)
        case .caption1:
            return Font(font: FontBook.font(.textFont, size: 12),
                          kern: 0,
                          lineHeight: 1.3)
        case .caption2:
            return Font(font: FontBook.font(.textFont, size: 11),
                          kern: 0.07,
                          lineHeight: 1.2)
        case .buttonInput:
            return Font(font: FontBook.font(.textFont, .medium, size: 16),
                          kern: -0.32,
                          lineHeight: 1.3)
        case .label:
            return Font(font: FontBook.font(.textFont, .medium, size: 13),
                          kern: -0.08,
                          lineHeight: 1.4)
        }
    }
    
    func checkFontAvailibility() {
        checkFontAvailibility(fontForStyle)
    }
    
    private func checkFontAvailibility(_ fontForStyle: (_ fontStyle: GLTheme.FontStyle) -> Font) {
        for style in GLTheme.FontStyle.allCases {
            let _ = fontForStyle(style).font
        }
    }
}
