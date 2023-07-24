//
//  CacheManager.swift
//  BrowsrLib
//
//  Created by Sunil Zishan on 24.07.23.
//

import Foundation

class CacheManager {
    static let shared = CacheManager()
    
    private let cache = NSCache<NSString, NSData>()
    
    
    @discardableResult
    func storeImageData(_ data: Data, for key: String) -> Bool {
        let nsData = data as NSData
        cache.setObject(nsData, forKey: key as NSString)
        return cache.object(forKey: key as NSString) != nil
    }
    
    func retrieveImageData(for key: String) -> Data? {
        return cache.object(forKey: key as NSString) as Data?
    }
    
    func clearCache() {
        cache.removeAllObjects()
    }
}
