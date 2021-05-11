//
//  Consts.swift
//  tmdb
//
//  Created by toha on 09.05.2021.
//

import UIKit

struct Consts {
    
    struct Layout {
        static let cellPosterSize: CGSize = .init(width: 80, height: 120)
        static let posterSize: CGSize = .init(width: 128, height: 192)
        static let profileImageSize: CGSize = .init(width: 112, height: 112)
    }
    
    enum ImageSize: String {
        case w45
        case w92
        case w154
        case w185
        case w300
        case w500
        case w780
        case original
    }
    
    static let searchDelay: TimeInterval = 0.2
    
    static let itemsPerFetch = 20
    
    static let searchBarPlaceholder = "Search"
    
    static let imageBaseUrl = "https://image.tmdb.org/t/p/"
    static let apiBaseUrl = "https://api.themoviedb.org/3/"
    static let apiKey = "087879f7d79a9ada3ed77d47ffe462fb"
    
    static let creditsImagePlaceholder = UIImage(systemName: "person.circle.fill")
}
