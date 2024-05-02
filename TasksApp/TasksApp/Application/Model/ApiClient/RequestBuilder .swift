//
//  RequestBuilder .swift
//  TasksApp
//
//  Created by user on 23.04.2024.
//

import Foundation
import Alamofire

protocol RequestBuilder {
    func build(path: String, method: HTTPMethod, headers: HTTPHeaders?, urlParameters: Parameters?) -> URLRequest?
}

struct RequestBuilderImpl: RequestBuilder {
    func build(path: String, method: HTTPMethod, headers: HTTPHeaders?, urlParameters: Parameters?) -> URLRequest? {
        var urlRequest = URL(string: path)
            .flatMap { try? URLEncoding().encode(URLRequest(url: $0), with: urlParameters)}
        urlRequest?.method = method
        urlRequest?.headers = headers ?? [:]
        return urlRequest
    }
}
