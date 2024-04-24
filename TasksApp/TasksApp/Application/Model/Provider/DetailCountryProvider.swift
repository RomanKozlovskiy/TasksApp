//
//  DetailCountryProvider.swift
//  TasksApp
//
//  Created by user on 24.04.2024.
//

import UIKit

final class DetailCountryProvider {
    private let cachingService: CachingService
    
    init(cachingService: CachingService) {
        self.cachingService = cachingService
    }
    
    func getCachedImage(for key: Int) -> UIImage? {
        cachingService.getCachedImage(for: key as AnyObject)
    }
    
    func cacheImage(image: UIImage, for key: Int) {
        cachingService.setImage(image: image, for: key as AnyObject)
    }
}
