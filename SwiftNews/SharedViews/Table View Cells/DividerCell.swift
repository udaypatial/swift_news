//
//  DividerCell.swift
//  TravelerWhitelabel
//
//  Created by Uday Patial on 2019-06-20.
//  Copyright © 2019 Uday Patial. All rights reserved.
//

import UIKit

class DividerCell: UITableViewCell {
    private let lineView = UIView()
    
    private var heightConstraint: NSLayoutConstraint!
    private var leftConstraint: NSLayoutConstraint!
    private var rightConstraint: NSLayoutConstraint!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func configure(height: CGFloat, inset: CGFloat) {
        heightConstraint.constant = height
        leftConstraint.constant = inset
        rightConstraint.constant = -inset
    }
    
    private func setup() {
        contentView.addSubview(lineView)
        lineView.backgroundColor = .tertiaryForegroundColor
        
        heightConstraint = lineView.constrainHeight(1)
        lineView.constrainTop(to: contentView)
        leftConstraint = lineView.constrainLeft(to: contentView)
        rightConstraint = lineView.constrainRight(to: contentView)
        lineView.constrainBottom(to: contentView, priority: UILayoutPriority(999))
    }
}
