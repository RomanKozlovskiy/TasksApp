//
//  CachingService .swift
//  TasksApp
//
//  Created by user on 02.05.2024.
//

import UIKit

class CachingService {
    private lazy var cachedDataSource: NSCache<AnyObject, AnyObject> = {
        let cache = NSCache<AnyObject, AnyObject>()
        return cache
    }()
    
    func objectFor(key: AnyObject) -> AnyObject? {
        if let cachedObject = cachedDataSource.object(forKey: key) {
            return cachedObject
        }
        return nil
    }
    
    func setObject(object: AnyObject, key: AnyObject) {
        cachedDataSource.setObject(object, forKey: key)
    }
}
