//
//  AppDelegate.swift
//  tmdb
//
//  Created by toha on 09.05.2021.
//

import Foundation

struct MovieDetails {
    let title: String?
    let name: String?
    let overview: String
    let poster: String?
    let genres: [Genre]
    let credits: Credits
    let date: String
}

extension MovieDetails: Decodable {
    enum CodingKeys: String, CodingKey {
        case title
        case name
        case overview
        case poster = "poster_path"
        case genres
        case credits
        case date = "release_date"
    }
}

struct Genre: Decodable {
    let name: String
}

extension MovieDetails {
    
    // some movies(TV shows) using title but some using name
    
    var titleName: String? {
        if let title = title {
            return title
        } else {
            return name
        }
    }
}
