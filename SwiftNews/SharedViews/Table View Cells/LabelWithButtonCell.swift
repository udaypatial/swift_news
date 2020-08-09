//
//  LabelWithButtonCell.swift
//  TravelerWhitelabel
//
//  Created by Uday Patial on 2019-07-31.
//  Copyright © 2019 Uday Patial. All rights reserved.
//

import UIKit

class LabelWithButtonCell: UITableViewCell {
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .darkPrimary
        return titleLabel
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.titleLabel?.textColor = GLTheme.shared().brandColor
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    private var buttonAction: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: NSAttributedString,
                   buttonTitle: NSAttributedString,
                   buttonAction: (() -> Void)?) {
        titleLabel.attributedText = title
        button.setAttributedTitle(buttonTitle, for: .normal)
        button.isHidden = buttonAction == nil
        self.buttonAction = buttonAction
    }
    
    private func setup() {
        backgroundColor = .clear
        
        configure(title: NSAttributedString(string: " "),
                  buttonTitle: NSAttributedString(string: " "),
                  buttonAction: nil)
        
        button.setHugging(.required, for: .horizontal)
        button.setCompressionResistance(.required, for: .horizontal)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(button)
        
        titleLabel.constrainEdgesVertically(to: contentView)
        titleLabel.constrainLeft(to: contentView, offset: AppTheme.ViewConstants.insetMargin)
        
        button.constrainEdgesVertically(to: contentView)
        button.constrainLeftToRight(of: titleLabel, offset: 5)
        button.constrainRight(to: contentView,
                              offset: -AppTheme.ViewConstants.insetMargin)
    }
    
    @objc private func buttonPressed() {
        guard let buttonAction = buttonAction else {
            return
        }
        
        buttonAction()
    }
}
