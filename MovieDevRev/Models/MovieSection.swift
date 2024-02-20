//
//  MovieSection.swift
//  MovieDevRev
//
//  Created by Anubhav Singh on 18/02/24.
//

import Foundation

struct MovieSection: Identifiable {
    
    let id = UUID()
    
    let movies: [Movie]
    let endpoint: MovieListEndpoint
    var title: String {
        endpoint.description
    }
    
    var thumbnailType: MovieThumbnailType {
        endpoint.thumbnailType
    }
}

fileprivate extension MovieListEndpoint {
    
    var thumbnailType: MovieThumbnailType {
        switch self {
        case .nowPlaying:
            return .latest()
        default:
            return .popular
        }
    }
    
}
