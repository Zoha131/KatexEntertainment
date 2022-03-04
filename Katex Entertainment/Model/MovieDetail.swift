//
//  MovieDetail.swift
//  Katex Entertainment
//
//  Created by MD Abir Hasan Zoha on 3/4/22.
//

import Foundation

struct MovieDetail: Codable {
    let id: String
    let title: String
    let year: String
    let image: String
    let releaseDate: String
    let runtimeMins: String
    let runtimeStr: String
    let plot: String
    let actorList: [Actor]
    let genres: String
    let iMDBRating: String
    let errorMessage: String?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case year
        case image
        case releaseDate
        case runtimeMins
        case runtimeStr
        case plot
        case actorList
        case genres
        case iMDBRating = "imDbRating"
        case errorMessage
    }
}
