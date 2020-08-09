//
//  WebServices.swift
//  SwiftNews
//
//  Created by Uday Patial on 2020-08-09.
//  Copyright © 2020 Uday Patial. All rights reserved.
//

import Foundation

enum NetCall<T: Codable>: String, NetworkCall, NetworkParams {
    
    typealias ResponseModel = T
    typealias RmtRequest = NetRequest
    
    case swiftNews = "swift_news"
    
    var url: String {
        switch self {
            case .swiftNews:
                return "https://www.reddit.com/r/swift/.json"
        }
    }
    
    var httpMethod: String {
        switch self {
            case .swiftNews:
                return "GET"
        }
    }
    
    var serviceName: String {
        return self.rawValue
    }
    
    func createRequest(_ url: String? = nil, reqHeaders: [String: String]? = nil, reqBody: Any? = nil) -> NetRequest {
        if url != nil {
            return NetRequest(url: url!, headers: reqHeaders, reqBody: reqBody)
        }
        
        return NetRequest(url: self.url, headers: reqHeaders, reqBody: reqBody)
    }
    
    var requestTimeOut: Int {
        return 20
    }
}
