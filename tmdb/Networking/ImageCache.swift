//
//  ImageCache.swift
//  tmdb
//
//  Created by toha on 11.05.2021.
//

import UIKit

class ImageCache {
    
    static let shared = ImageCache()
    
    private let lock = NSLock()

    private lazy var imageCache: NSCache<AnyObject, AnyObject> = {
        let cache = NSCache<AnyObject, AnyObject>()
        cache.countLimit = 256
        cache.totalCostLimit = 1024 * 1024 * 100
        return cache
    }()
    
    func getImage(for url: String) -> UIImage? {
        
        let urlKey = NSString(string: url)
        
        lock.lock(); defer { lock.unlock() }

        if let image = imageCache.object(forKey: urlKey as AnyObject) as? UIImage {
            return image
        } else {
            return nil
        }
    }

    func setImage(_ image: UIImage, for url: String) {
        let urlKey = NSString(string: url)

        lock.lock(); defer { lock.unlock() }
        imageCache.setObject(image, forKey: urlKey)
    }
    
}
