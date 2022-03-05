//
//  MovieDetailViewModel.swift
//  Katex Entertainment
//
//  Created by MD Abir Hasan Zoha on 3/5/22.
//

import Foundation

struct MovieDetailState {
    var detail: Async<MovieDetail> = .uninitialized
}

@MainActor
class MovieDetailViewModel: ObservableObject {
    let movieClient = MovieClientImp (
        baseUrl: "https://imdb-api.com",
        securityKey: "k_36fx4wxd",
        urlSession: .shared,
        jsonDecoder: JSONDecoder()
    )

    @Published private(set) var state = MovieDetailState()

    func loadDetail(of id: String) async {
        state.detail = .loading(progress: 0)

        do {
            let detail = try await movieClient.getMovieDetail(of: id)
            state.detail = .success(value: detail)
        } catch {
            state.detail = .failed(error: error)
        }
    }
}
