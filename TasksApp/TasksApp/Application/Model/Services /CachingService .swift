//
//  CachingService .swift
//  TasksApp
//
//  Created by user on 24.04.2024.
//

import UIKit

final class CachingService {
    private lazy var cachedDaraSource: NSCache<AnyObject, UIImage> = {
        let cache = NSCache<AnyObject, UIImage>()
        return cache
    }()
    
    func getCachedImage<T: AnyObject>(for key: T) -> UIImage? {
        return cachedDaraSource.object(forKey: key)
    }
    
    func setImage<T: AnyObject>(image: UIImage, for key: T) {
        cachedDaraSource.setObject(image, forKey: key)
    }
}
