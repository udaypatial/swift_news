//
//  NewsItemImageCell.swift
//  SwiftNews
//
//  Created by Uday Patial on 2020-08-09.
//  Copyright © 2020 Uday Patial. All rights reserved.
//

import UIKit
import Kingfisher

class NewsItemImageCell: UITableViewCell {
    
    private lazy var newsTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .bgWhite
        return label
    }()
    
    private lazy var newsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: AppTheme.ViewConstants.newsPlaceholder)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.addOverlay()
        return imageView
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
        
        contentView.addSubview(newsImage)
        contentView.addSubview(newsTitleLabel)
        
        constrainViews()
    }
    
    private func constrainViews() {
        newsImage.constrainEdges(to: contentView)
        newsImage.constrainHeight(200)
        
        newsTitleLabel.constrainEdgesHorizontally(to: contentView, offset: AppTheme.ViewConstants.M_10)
        newsTitleLabel.constrainBottom(to: contentView, offset: -AppTheme.ViewConstants.M_10)
    }
    
    public func configure(for news: NewsArticle) {
        newsTitleLabel.text = news.title
        
        if let imageUrlString = news.thumbnailImage,
            let imageUrl = URL(string: imageUrlString) {
            newsImage.kf.setImage(with: imageUrl, placeholder: UIImage(named: AppTheme.ViewConstants.newsPlaceholder))
        }
    }
}
