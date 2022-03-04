//
//  MovieClient.swift
//  Katex Entertainment
//
//  Created by MD Abir Hasan Zoha on 3/4/22.
//

import Foundation

protocol MovieClient {
    var baseUrl: String { get }

    var securityKey: String { get }

    func getPopularMovies(_ completion: @escaping (Result<[Movie], Error>) -> ())

    func searchMovie(query: String) async throws -> [Movie]

    func getMovieDetail(of id: String) async throws -> MovieDetail
}
