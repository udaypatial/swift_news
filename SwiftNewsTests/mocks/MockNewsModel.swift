//
//  MockNewsModel.swift
//  SwiftNewsTests
//
//  Created by Uday Patial on 2020-08-09.
//  Copyright © 2020 Uday Patial. All rights reserved.
//

import Foundation

class MockModel {
    func mockArticles(withError: NetworkError?) -> APIResponse<NewsArticle> {
        let url = Bundle(for: type(of: self)).url(forResource: "news_article_list", withExtension: "json")!
        
        let decoder = JSONDecoder()
        let jsonData = try! Data(contentsOf: url)
        let apiResponse = try! decoder.decode(APIResponse<NewsArticle>.self, from: jsonData)
        return apiResponse
    }
}
