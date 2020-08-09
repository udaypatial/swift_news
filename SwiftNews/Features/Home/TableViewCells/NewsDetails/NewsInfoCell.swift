//
//  NewsInfoCell.swift
//  SwiftNews
//
//  Created by Uday Patial on 2020-08-09.
//  Copyright © 2020 Uday Patial. All rights reserved.
//

import UIKit

class NewsInfoCell: UITableViewCell {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .darkPrimary
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .darkSecondary
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        backgroundColor = .clear
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        
        constrainViews()
    }
    
    private func constrainViews() {
        titleLabel.constrainEdgesHorizontally(to: contentView, offset: AppTheme.ViewConstants.M_10)
        titleLabel.constrainTop(to: contentView, offset: AppTheme.ViewConstants.M_10)
        
        descriptionLabel.constrainTopToBottom(of: titleLabel, offset: AppTheme.ViewConstants.M_10)
        descriptionLabel.constrainEdgesHorizontally(to: contentView, offset: AppTheme.ViewConstants.M_10)
        descriptionLabel.constrainBottom(to: contentView)
    }
    
    public func configure(title: String, description: String) {
        titleLabel.text = title
        descriptionLabel.text = description
    }
}
