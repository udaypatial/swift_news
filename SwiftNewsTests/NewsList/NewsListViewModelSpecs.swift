//
//  NewsListViewModelSpecs.swift
//  SwiftNewsTests
//
//  Created by Uday Patial on 2020-08-09.
//  Copyright © 2020 Uday Patial. All rights reserved.
//

import Quick
import Nimble
import Foundation

class NewsListViewModelSpecs: QuickSpec {
    
    override func spec() {
        var viewModel: NewsListViewModel!
        let mockAPIDataManager = MockAPIDataManager()
        beforeEach {
            viewModel = NewsListViewModel(apiDataManager: mockAPIDataManager)
        }
        
        describe("News List View Model") {
            context("when fetching the News") {
                it("fetches the News with success") {
                    mockAPIDataManager.shouldSucceed = true
                    viewModel.fetchNewsArticles(onSuccess: { newsArticles in
                        expect(newsArticles.count).to(equal(1))
                    }) { _ in }
                    expect(viewModel.sections.count).toEventually(equal(1))
                    expect(viewModel.sections[0].count).toEventually(equal(1))
                }
                
                it("fetches the News with error") {
                    mockAPIDataManager.shouldSucceed = false
                    viewModel.fetchNewsArticles(onSuccess: { _ in
                    }) { err in
                        expect(err).to(equal(.badURL))
                    }
                }
            }
        }
    }
}

class MockAPIDataManager: APIDataManager {
    var shouldSucceed = false
    var invalidJSON = true
    
    override func getNewsArticleList(onComplete: @escaping (Result<APIResponse<NewsArticle>, NetworkError>) -> Void) {
        (shouldSucceed == true) ? onComplete(.success(MockModel().mockArticles(withError: nil))) : onComplete(.failure(.badURL))
    }
}
