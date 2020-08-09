//
//  Title1Cell.swift
//  TravelerWhitelabel
//
//  Created by Uday Patial on 2019-06-12.
//  Copyright © 2019 Uday Patial. All rights reserved.
//

import UIKit

class LabelCell: UITableViewCell {
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .darkPrimary
        return titleLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: NSAttributedString, numberOfLines: Int) {
        titleLabel.attributedText = title
        titleLabel.numberOfLines = numberOfLines
    }
    
    private func setup() {
        backgroundColor = .clear
        
        configure(title: NSAttributedString(string: " "), numberOfLines: 1)
        
        contentView.addSubview(titleLabel)
        titleLabel.constrainEdges(to: contentView, insets: UIEdgeInsets(top: 0, left: AppTheme.ViewConstants.insetMargin, bottom: 0, right: AppTheme.ViewConstants.insetMargin))
    }
}


