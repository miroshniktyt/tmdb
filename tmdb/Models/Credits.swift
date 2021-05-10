//
//  Cast.swift
//  tmdb
//
//  Created by toha on 10.05.2021.
//

import Foundation

struct Credits: Decodable {
    let cast: [Cast]
    let crew: [Crew]
}
