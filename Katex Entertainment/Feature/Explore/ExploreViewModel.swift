//
//  ExploreViewModel.swift
//  Katex Entertainment
//
//  Created by MD Abir Hasan Zoha on 3/4/22.
//

import Foundation

struct ExploreState {
    var suggestions: Async<[Movie]> = .uninitialized
    var popularMovies: Async<[Movie]> = .uninitialized
    var searchMovies: Async<[Movie]> = .uninitialized
}

@MainActor
class ExploreViewModel: ObservableObject {
    let movieClient = MovieClientImp(
        baseUrl: "https://imdb-api.com",
        securityKey: "k_i6f1t24j",
        urlSession: .shared,
        jsonDecoder: JSONDecoder()
    )

    @Published private(set) var state = ExploreState()
    @Published var query = ""

    func clearQuery() {
        query = ""
        state.searchMovies = .uninitialized
    }

    func loadPopularMovies() {
        state.popularMovies = .loading(progress: 0)

        movieClient.getPopularMovies {[weak self] result in
            guard let self = self else {
                return
            }

            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    let lastIndex = min(6, movies.count)
                    self.state.popularMovies = .success(value: Array(movies[..<lastIndex]))
                case .failure(let error):
                    self.state.popularMovies = .failed(error: error)
                }
            }
        }
    }

    func searchMovies() async {
        state.searchMovies = .loading(progress: 0)
        do {
            let movies = try await movieClient.searchMovie(query: query)
            state.searchMovies = .success(value: movies)
        } catch {
            state.searchMovies = .failed(error: error)
        }
    }
}
