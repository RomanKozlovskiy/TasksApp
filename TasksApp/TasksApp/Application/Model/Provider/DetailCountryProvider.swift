//
//  DetailCountryProvider.swift
//  TasksApp
//
//  Created by user on 02.05.2024.
//

import UIKit

final class DetailCountryProvider {
    private let cachingService: CachingService
    
    init(cachingService: CachingService) {
        self.cachingService = cachingService
    }
    
    func getCachedObject(for key: AnyObject) -> UIImage? {
        cachingService.objectFor(key: key) as? UIImage
    }
    
    func setCachedObject(image: UIImage, key: AnyObject) {
        cachingService.setObject(object: image, key: key)
    }
}
