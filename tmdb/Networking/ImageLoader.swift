//
//  ImageLoader.swift
//  tmdb
//
//  Created by toha on 10.05.2021.
//

import UIKit

struct ImageLoader {
    
    func setImage(for imageView: UIImageView, with url: String) {
        let cache = ImageCache.shared
        
        if let image = cache.getImage(for: url) {
            imageView.image = image
        } else {
            fetchImage(for: url) { (image) in
                if let image = image {
                    imageView.image = image
                    cache.setImage(image, for: url)
                } else {
                    print("can't fetch image for: \(url)")
                }
            }
        }
    }
    
    private func fetchImage(for url: String, completion: @escaping (UIImage?) -> ()) {
        guard let url = URL(string: url) else { return }
        
        DispatchQueue.global(qos: .userInitiated).async {
            let data = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                if let data = data {
                    let image = UIImage(data: data)
                    completion(image)
                } else {
                    completion(nil)
                }
            }
        }
    }
}
