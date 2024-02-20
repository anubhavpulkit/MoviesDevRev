//
//  MovieStore.swift
//  MovieDevRev
//
//  Created by Anubhav Singh on 18/02/24.
//

import Foundation
import NetworkingKit

class MovieStore: MovieService {
    
    static let shared = MovieStore()
    private init() {}
    
    private let apiKey = "76d24b0cf915a4337d252119692ebe10"
    private let baseAPIURL = "https://api.themoviedb.org/3"
    private let urlSession = URLSession.shared
    private let jsonDecoder = Utils.jsonDecoder
    
    func fetchMovies(from endpoint: MovieListEndpoint) async throws -> [Movie] {
        guard let url = URL(string: "\(baseAPIURL)/movie/\(endpoint.rawValue)") else {
            throw MovieError.invalidEndpoint
        }
        let movieResponse: MovieResponse = try await loadURLAndDecode(url: url, apiKey: apiKey)
        return movieResponse.results
    }
    
    func fetchMovie(id: Int) async throws -> Movie {
        guard let url = URL(string: "\(baseAPIURL)/movie/\(id)") else {
            throw MovieError.invalidEndpoint
        }
        return try await loadURLAndDecode(url: url, apiKey: apiKey, params: [
                        "append_to_response": "videos,credits"
        ])
    }
}
