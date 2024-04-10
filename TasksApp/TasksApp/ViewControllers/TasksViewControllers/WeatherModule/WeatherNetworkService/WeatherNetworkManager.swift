//
//  WeatherNetworkManager.swift
//  TasksApp
//
//  Created by user on 10.04.2024.
//

import Foundation
import Alamofire

protocol WeatherNetworkProtocol {
    func makeRequest<T: Decodable>(type: T.Type, completion: @escaping (Result<T?, Error>) -> Void)
}

final class WeatherNetworkManager: WeatherNetworkProtocol {
    func makeRequest<T: Decodable>(type: T.Type, completion: @escaping (Result<T?, Error>) -> Void) {
        let parameters = Constants.rostovCoordinates
        let headers: HTTPHeaders = [Keys.yandexAccess: yandexAccessKeyValue]
        AF.request(baseURL, parameters: parameters, headers: headers)
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

private extension WeatherNetworkManager {
    private var baseURL: String {
        guard let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
              let dictionary = NSDictionary(contentsOfFile: path),
              let baseUrl = dictionary[Keys.baseUrl] as? String else {
            fatalError("cannot find value by key baseUrl")
        }
        return baseUrl
    }
    
    private var yandexAccessKeyValue: String {
        guard let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
              let dictionary = NSDictionary(contentsOfFile: path),
              let accessDictValue = dictionary[Keys.apiKey] as? String else {
            fatalError("cannot find value by key APIAccessKey")
        }
        return accessDictValue
    }
    
    enum Keys {
        static let baseUrl = "baseURL"
        static let apiKey = "APIAccessKey"
        static let yandexAccess = "X-Yandex-Weather-Key"
    }
    
    enum Constants {
        static let rostovCoordinates = ["lat": "47.2313", "lon": "39.7233"]
    }
}
