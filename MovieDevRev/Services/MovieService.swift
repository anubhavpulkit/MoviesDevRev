//
//  MovieService.swift
//  MovieDevRev
//
//  Created by Anubhav Singh on 18/02/24.
//

import Foundation

protocol MovieService {
    
    func fetchMovies(from endpoint: MovieListEndpoint) async throws -> [Movie]
    func fetchMovie(id: Int) async throws -> Movie
}

enum MovieListEndpoint: String, CaseIterable, Identifiable {
    
    var id: String { rawValue }
    
    case nowPlaying = "now_playing"
    case popular
    
    var description: String {
        switch self {
            case .nowPlaying: return "Latest"
            case .popular: return "Popular"
        }
    }
}
