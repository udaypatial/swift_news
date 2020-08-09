//
//  SpacerCell.swift
//  TravelerWhitelabel
//
//  Created by Uday Patial on 2019-06-12.
//  Copyright © 2019 Uday Patial. All rights reserved.
//

import UIKit

class SpacerCell: UITableViewCell {
    private var heightConstraint: NSLayoutConstraint!
    private let content = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(height: CGFloat) {
        heightConstraint.constant = height
    }
    
    private func setup() {
        backgroundColor = .clear
        contentView.addSubview(content)
        content.constrainEdges(to: contentView)
        heightConstraint = content.constrainHeight(0, priority: UILayoutPriority(rawValue: 999))
    }
}
