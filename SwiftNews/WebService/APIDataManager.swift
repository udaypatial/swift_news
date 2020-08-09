//
//  APIDataManager.swift
//  SwiftNews
//
//  Created by Uday Patial on 2020-08-09.
//  Copyright © 2020 Uday Patial. All rights reserved.
//

import UIKit

enum NetworkError: Error {
    case badURL
    case apiError
    case invalidJSON
}

struct APIResponse<T: Codable>: Codable {
    let data: Datum<T>
    
    struct Datum<T: Codable>: Codable {
        let children: [ItemData<T>]
    }
}

struct ItemData<T: Codable>: Codable {
    let data: T
}

class APIDataManager {
    func getNewsArticleList(onComplete: @escaping (Result<APIResponse<NewsArticle>, NetworkError>) -> Void) {
        let swiftNewsCall = NetCall<APIResponse<NewsArticle>>.swiftNews
        swiftNewsCall.makeRequest(swiftNewsCall.createRequest()) { result in
            DispatchQueue.main.async {
                onComplete(result)
            }
        }
    }
}
