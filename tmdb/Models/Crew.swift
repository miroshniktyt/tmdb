//
//  Crew.swift
//  tmdb
//
//  Created by toha on 10.05.2021.
//

import Foundation

struct Crew: Decodable {
    let department: String
    let job: String
    let name: String
    let image: String?
}

extension Crew: CreditType {
    var subtitle: String {
        return self.job
    }
}
