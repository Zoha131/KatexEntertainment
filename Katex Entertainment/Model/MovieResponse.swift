//
//  MovieResponse.swift
//  Katex Entertainment
//
//  Created by MD Abir Hasan Zoha on 3/4/22.
//

import Foundation

struct MovieResponse: Codable {
    let queryString: String
    let results: [Movie]
    let errorMessage: String?
}
