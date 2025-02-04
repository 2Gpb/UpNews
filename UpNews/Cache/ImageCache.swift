//
//  ImageCache.swift
//  UpNews
//
//  Created by Peter on 04.02.2025.
//

import UIKit

final class ImageCache {
    static let shared: ImageCache = ImageCache()
    
    private let cache: NSCache = NSCache<NSString, UIImage>()
    private let queue: DispatchQueue = DispatchQueue(label: "com.upnews.imageCache")
    
    func setImage(image: UIImage, forkey key: String) {
        queue.async {
            self.cache.setObject(image, forKey: key as NSString)
        }
    }
    
    func getImage(forKey key: String) -> UIImage? {
        queue.sync {
            cache.object(forKey: key as NSString)
        }
    }
    
    func clearCache() {
        queue.async {
            self.cache.removeAllObjects()
        }
    }
}
