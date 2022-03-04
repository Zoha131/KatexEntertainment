//
//  ExploreViewModel.swift
//  Katex Entertainment
//
//  Created by MD Abir Hasan Zoha on 3/4/22.
//

import Foundation

class ExploreViewModel: ObservableObject {
    let movieClient = MovieClientImp(
        baseUrl: "https://imdb-api.com",
        securityKey: "k_i6f1t24j",
        urlSession: .shared,
        jsonDecoder: JSONDecoder()
    )
}
