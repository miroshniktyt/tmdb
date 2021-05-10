//
//  AppDelegate.swift
//  tmdb
//
//  Created by toha on 09.05.2021.
//

import Foundation

struct Trending: Decodable {
    let page: Int
    let results: [Movie]
    let total_pages: Int
    let total_results: Int
}

struct Movie {
    let id: Int
    let title: String
    let overview: String
    let poster: String?
}

extension Movie: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case poster = "poster_path"
    }
}
