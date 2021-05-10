//
//  Cast.swift
//  tmdb
//
//  Created by toha on 10.05.2021.
//

import Foundation

struct Cast {
    let character: String
    let name: String
    let image: String?
}

extension Cast: Decodable {
    enum CodingKeys: String, CodingKey {
        case character
        case name
        case image = "profile_path"
    }
}

extension Cast: CreditType {
    var subtitle: String {
        return self.character
    }
}
