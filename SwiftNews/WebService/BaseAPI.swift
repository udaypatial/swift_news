//
//  BaseAPI.swift
//  SwiftNews
//
//  Created by Uday Patial on 2020-08-09.
//  Copyright © 2020 Uday Patial. All rights reserved.
//

import Foundation

struct NetResponse {
    let statusCode: Int
    let errorCode: String?
    let respBody: Data?
}

struct NetRequest {
    let url: String
    let headers: [String: String]?
    let reqBody: Any?
    let requestTimeOut: Float?
    let httpMethod: String?
    
    init(url: String,
         headers: [String: String]? = nil,
         reqBody: Any? = nil,
         reqTimeout: Float? = nil,
         httpMethod: String? = nil) {
        self.url = url
        self.headers = headers
        self.reqBody = reqBody
        self.requestTimeOut = reqTimeout
        self.httpMethod = httpMethod
    }
}

protocol NetworkCall {
    associatedtype ResponseModel: Codable
    var requestTimeOut: Int { get }
    var httpMethod: String { get }
    func makeRequest(_ req: NetRequest, onComplete: @escaping (Result<ResponseModel, NetworkError>) -> Void)
}

extension NetworkCall {
    
    func makeRequest(_ req: NetRequest, onComplete: @escaping (Result<ResponseModel, NetworkError>) -> Void) {
        
        if let timeout = req.requestTimeOut {
            let sessionConfig = URLSessionConfiguration.default
            sessionConfig.timeoutIntervalForRequest = TimeInterval(timeout)  //Request Timeout interval 30 sec
        } else {
            let sessionConfig = URLSessionConfiguration.default
            sessionConfig.timeoutIntervalForRequest = TimeInterval(requestTimeOut)
        }
        
        guard let url = URL(string: req.url) else {
            onComplete(.failure(.badURL))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = req.httpMethod
        urlRequest.allHTTPHeaderFields = req.headers ?? [:]
        
        let task = URLSession.shared.dataTask(
            with: urlRequest,
            completionHandler: {
                (data, response, error) in
                if let respData = data {
                    let decoder = JSONDecoder()
                    do {
                        let decoded = try decoder.decode(ResponseModel.self, from: respData)
                        onComplete(.success(decoded))
                    } catch let e {
                        print(e)
                        onComplete(.failure(.invalidJSON))
                    }
                } else {
                    onComplete(.failure(.apiError))
                }
        })
        task.resume()
    }
}

protocol NetworkParams {
    var url: String { get }
    var httpTimeout: Int { get }
}

extension NetworkParams {
    var httpTimeout: Int { return 20 }
}
