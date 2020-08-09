//
//  GLButton.swift
//  TravelerWhitelabel
//
//  Created by Uday Patial on 2019-06-05.
//  Copyright © 2019 Uday Patial. All rights reserved.
//

import UIKit

class GLButton: UIButton {
    
    enum Style {
        case primary, secondary
    }
    
    var style: Style = .primary {
        didSet {
            updateForStyle()
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            updateForStyle()
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            updateForStyle()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func configure(title: String) {
        setButtonTitle(title)
    }
    
    private func commonInit() {
        layer.cornerRadius = 4
        updateForStyle()
        constrainHeight(44)
    }
    
    private func updateForStyle() {
        backgroundColor = backgroundColorForStyle()
        
        let titleText = attributedTitle(for: .normal)?.string ?? ""
        setButtonTitle(titleText)
        
        updateBorderColor()
        
        alpha = isHighlighted ? 0.6 : 1.0
    }
    
    private func setButtonTitle(_ string: String) {
        let string: NSAttributedString = .buttonInput(string, color: textColorForStyle())
        setAttributedTitle(string, for: .normal)
    }
    
    private func backgroundColorForStyle() -> UIColor {
        guard  isEnabled else {
            return .tertiaryForegroundColor
        }
        switch style {
            case .primary:
                return GLTheme.shared().brandColor
            case .secondary:
                return .bgWhite
        }
    }
    
    private func textColorForStyle() -> UIColor {
        switch style {
            case .primary:
                return .bgWhite
            case .secondary:
                return GLTheme.shared().brandColor
        }
    }
    
    private func updateBorderColor() {
        switch style {
            case .primary:
                layer.borderWidth = 0
            case .secondary:
                layer.borderColor = GLTheme.shared().brandColor.cgColor
                layer.borderWidth = 1
        }
    }
}
