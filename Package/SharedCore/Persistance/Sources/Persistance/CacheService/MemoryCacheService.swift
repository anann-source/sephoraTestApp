//
//  MemoryCacheService.swift
//  Persistance
//
//  Created by Chuon Anann on 04/05/2025.
//

import Foundation

public protocol MemoryCacheService {
    func setData<T>(_ data: T, forKey key: String)
    func getData<T>(forKey key: String) -> T?
}

/* NSCache clear the memory when we relauch the app */
public class MemoryCacheServiceImpl: MemoryCacheService {
    private let cache = NSCache<NSString, CachedObject>()
    private let expirationInterval: TimeInterval
    
    public init(expirationInterval: TimeInterval = 60 * 60) {
        self.expirationInterval = expirationInterval
    }
    
    public func setData<T>(_ data: T, forKey key: String) {
        let cacheObject = CachedObject(data: data, timestamp: Date())
        cache.setObject(cacheObject, forKey: key as NSString)
    }
    
    public func getData<T>(forKey key: String) -> T? {
        guard let cachedObject = cache.object(forKey: key as NSString) else {
            debugPrint("There is no cache for key \(key)")
            return nil
        }
        
        // We check the expiration of the object stored compared to today date
        if Date().timeIntervalSince(cachedObject.timestamp) > expirationInterval {
            cache.removeObject(forKey: key as NSString)
            debugPrint("cache for key \(key) expired")
            return nil
        }
        
        debugPrint("cache for key \(key) has not expired yet")

        return cachedObject.data as? T
    }
    
    // Store data and timestamp cached
    private class CachedObject {
        let data: Any
        let timestamp: Date
        
        init(data: Any, timestamp: Date) {
            self.data = data
            self.timestamp = timestamp
        }
    }
}
