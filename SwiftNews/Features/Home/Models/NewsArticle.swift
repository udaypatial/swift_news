//
//  News.swift
//  SwiftNews
//
//  Created by Uday Patial on 2020-08-09.
//  Copyright © 2020 Uday Patial. All rights reserved.
//

struct NewsArticle: Codable {
    
    let title: String
    let thumbnailImage: String?
    let description: String?
    
    enum CodingKeys: String, CodingKey {
        case thumbnailImage = "thumbnail"
        case description = "selftext"
        case title
    }
}
