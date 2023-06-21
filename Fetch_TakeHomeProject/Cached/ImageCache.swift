//
//  ImageCache.swift
//  Fetch_TakeHomeProject
//
//  Created by Boone on 6/20/23.
//

import Foundation

class ImageCache {
    // We want to use a String since the key will be the URL. The value will be the image object stored as Data
    typealias CacheType = NSCache<NSString, NSData>

    // We want this to be a singleton because SwiftUI views are re-invalidated each time the state changes. We don't want the Cache to be reset when the view is re-rendered.
    static let shared = ImageCache()

    // private so no one can create it
    private init() {}

    // won't be initialized until we actually create the cache
    private lazy var cache: CacheType = {
        let cache = CacheType()
        // can have 100 items within the Cache
        cache.countLimit = 100
        // 52,428,800 bytes -> 50MB
        cache.totalCostLimit = 50 * 1024 * 1024
        return cache
    }()

    // Get from Cache
    func object(forKey key: NSString) -> Data? {
        cache.object(forKey: key) as? Data
    }

    // Save to Cache
    func set(object: NSData, forKey key: NSString) {
        cache.setObject(object, forKey: key)
    }
}
