//
//  CountriesProvider.swift
//  TasksApp
//
//  Created by user on 23.04.2024.
//

import UIKit

final class CountriesProvider {
    private let countriesApiClient: CountriesApiClient
    private let cachingService: CachingService
    
    init(countriesApiClient: CountriesApiClient, cachingService: CachingService) {
        self.countriesApiClient = countriesApiClient
        self.cachingService = cachingService
    }
    
    func fetchCountries(nextPage: String? = nil, completion: @escaping (CountryList?) -> Void) {
        countriesApiClient.makeRequest(nextPage: nextPage, type: CountryList.self) { result in
            switch result {
            case .success(let countryList):
                DispatchQueue.main.async {
                    completion(countryList)
                }
            case .failure(let error):
                print(error)
                completion(nil)
            }
        }
    }
    
    func getCachedImage(for key: Int) -> UIImage? {
        cachingService.getCachedImage(for: key as AnyObject)
    }
    
    func cacheImage(image: UIImage, for key: Int) {
        cachingService.setImage(image: image, for: key as AnyObject)
    }
}
