//
//  NewsImageCell.swift
//  SwiftNews
//
//  Created by Uday Patial on 2020-08-09.
//  Copyright © 2020 Uday Patial. All rights reserved.
//

import UIKit

class NewsImageCell: UITableViewCell {
    
    private lazy var newsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: AppTheme.ViewConstants.newsPlaceholder)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
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
        
        constrainViews()
    }
    
    private func constrainViews() {
        newsImage.constrainHeight(200)
        newsImage.constrainEdges(to: contentView)
    }
    
    public func configure(for imageUrl: String?) {
        if let urlString = imageUrl,
            let url = URL(string: urlString) {
            newsImage.kf.setImage(with: url, placeholder: UIImage(named: AppTheme.ViewConstants.newsPlaceholder))
        }
    }
}
