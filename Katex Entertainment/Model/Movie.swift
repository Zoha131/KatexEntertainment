//
//  Movie.swift
//  Katex Entertainment
//
//  Created by MD Abir Hasan Zoha on 3/4/22.
//

import Foundation

struct Movie: Codable, Identifiable {
    let id: String
    let image: String
    let title: String
    let description: String
    let runtimeStr: String?
    let genres: String
    let iMDBRating: String?

    enum CodingKeys: String, CodingKey {
        case id
        case image
        case title
        case description = "description"
        case runtimeStr
        case genres
        case iMDBRating = "imDbRating"
    }
}

extension Movie {
    var year: String {
        
        return String(description.replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: ""))
    }
}
