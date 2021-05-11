//
//  ImageSetter.swift
//  tmdb
//
//  Created by toha on 11.05.2021.
//

import UIKit

extension UIImageView {
    func setImage(path: String?, size: Consts.ImageSize, defaultImage: UIImage? = nil) {
        guard let path = path else {
            self.image = defaultImage
            return
        }
        
        let imageUrl = Consts.imageBaseUrl + size.rawValue + path
        let loader = ImageLoader()
        loader.setImage(for: self, with: imageUrl)
    }
}
