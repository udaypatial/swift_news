//
//  NewsItemTextCell.swift
//  SwiftNews
//
//  Created by Uday Patial on 2020-08-09.
//  Copyright © 2020 Uday Patial. All rights reserved.
//

import UIKit

class NewsItemTextCell: UITableViewCell {
    
    private lazy var newsTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .darkPrimary
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
        
        contentView.addSubview(newsTitleLabel)
        
        constrainViews()
    }
    
    private func constrainViews() {
        newsTitleLabel.constrainEdgesHorizontally(to: contentView, offset: AppTheme.ViewConstants.M_10)
        newsTitleLabel.constrainEdgesVertically(to: contentView, offset: AppTheme.ViewConstants.M_10)
    }
    
    public func configure(for news: NewsArticle) {
        newsTitleLabel.text = news.title
    }
}
