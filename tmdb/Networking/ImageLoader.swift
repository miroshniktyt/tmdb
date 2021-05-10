//
//  ImageLoader.swift
//  tmdb
//
//  Created by toha on 10.05.2021.
//

import UIKit


extension UIImageView {
    
    func setDefauldImage() {
        image = UIImage(systemName: "person.circle.fill")
        tintColor = .secondarySystemBackground
    }
    
    func setImage(path: String?, size: Consts.ImageSize = .w154) {
        guard let path = path else {
            setDefauldImage()
            return
        }
        
        let urlString = Consts.imageBaseUrl + size.rawValue + path
                
        fetchImage(urlString: urlString)
    }
    
    func fetchImage(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        DispatchQueue.global(qos: .userInitiated).async {
            let data = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                if let data = data {
                    let image = UIImage(data: data)
                    self.image = image
                }
            }
        }
    }
}
