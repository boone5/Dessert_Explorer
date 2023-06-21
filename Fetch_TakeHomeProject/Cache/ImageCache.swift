//
//  ImageCache.swift
//  Fetch_TakeHomeProject
//
//  Created by Boone on 6/20/23.
//

import Foundation

class ImageCache {
    // The key will be a String representation of the URL. The value will be the image object stored as Data.
    typealias CacheType = NSCache<NSString, NSData>

    // MARK: Singleton
    // SwiftUI views are re-rendered so we don't want the cache to reset.
    static let shared = ImageCache()

    // Keeps the instantiation explicit to this file.
    private init() {}

    private lazy var cache: CacheType = {
        let cache = CacheType()
        cache.countLimit = 100
        // 52,428,800 bytes -> 50MB
        cache.totalCostLimit = 50 * 1024 * 1024
        return cache
    }()

    // Get from Cache
    func getObject(forKey key: NSString) -> Data? {
        cache.object(forKey: key) as? Data
    }

    // Save to Cache
    func set(object: NSData, forKey key: NSString) {
        cache.setObject(object, forKey: key)
    }
}
