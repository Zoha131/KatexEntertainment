//
//  MovieClientImp.swift
//  Katex Entertainment
//
//  Created by MD Abir Hasan Zoha on 3/4/22.
//

import Foundation

class MovieClientImp: MovieClient {
    let baseUrl: String
    let securityKey: String
    let urlSession: URLSession
    let jsonDecoder: JSONDecoder

    init(baseUrl: String, securityKey: String, urlSession: URLSession, jsonDecoder: JSONDecoder) {
        self.baseUrl = baseUrl
        self.securityKey = securityKey
        self.urlSession = urlSession
        self.jsonDecoder = jsonDecoder
    }

    func getPopularMovies(_ completion: @escaping (Result<[Movie], Error>) -> ()) {
        let urlString = "\(baseUrl)/API/AdvancedSearch/\(securityKey)?groups=top_100"

        guard let url = URL(string: urlString) else {
            completion(.failure(URLError(.badURL)))
            return
        }

        urlSession.dataTask(with: url) { [weak self] data, _, error in
            guard
                let data = data,
                let self = self
            else {
                let error = error ?? KatexError.unKnown
                completion(.failure(error))

                return
            }

            do {
                let result = try self.jsonDecoder.decode(MovieResponse.self, from: data)

                completion(.success(result.results))
            } catch {
                completion(.failure(error))
            }
        }
        .resume()
    }

    func searchMovie(query: String) async throws -> [Movie] {
        let urlString = "\(baseUrl)/API/AdvancedSearch/\(securityKey)?keywords=\(query)"

        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, _) = try await urlSession.data(from: url)
        let result = try jsonDecoder.decode(MovieResponse.self, from: data)

        return result.results
    }

    func getMovieDetail(of id: String) async throws -> MovieDetail {
        let urlString = "\(baseUrl)/API/Title/\(securityKey)/\(id)"

        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, _) = try await urlSession.data(from: url)
        let result = try jsonDecoder.decode(MovieDetail.self, from: data)

        return result
    }
}
