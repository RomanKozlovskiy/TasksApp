//
//  CountriesApiClient.swift
//  TasksApp
//
//  Created by user on 23.04.2024.
//

import Foundation
import Alamofire

class CountriesApiClient {
    private let configuration: Configuration
    private let requestBuilder: RequestBuilder
    
    init(configuration: Configuration, requestBuilder: RequestBuilder) {
        self.configuration = configuration
        self.requestBuilder = requestBuilder
    }
    
    func makeRequest<T: Decodable>(nextPage: String? = nil, type: T.Type, completion: @escaping (Result<T?, Error>) -> Void) {
        guard let request = requestBuilder.build(path: nextPage ?? configuration.path, method: .get, headers: [:], urlParameters: nil) else { return } //TODO: обработать ошибки
        AF.request(request)
            .responseDecodable(of: type.self) { response in
            switch response.result {
            case .success(let responseData):
                completion(.success(responseData))
            case .failure(let responseError):
                completion(.failure(responseError))
            }
        }
    }
}

