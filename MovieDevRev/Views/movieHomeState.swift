//
//  movieHomeState.swift
//  MovieDevRev
//
//  Created by Anubhav Singh on 19/02/24.
//

import SwiftUI

struct MovieHomeView: View {
    @StateObject private var movieHomeState = MovieHomeState()
    
    var body: some View {
        TabView {
            ForEach(movieHomeState.sections) { section in
                MovieThumbnailGridView(
                    title: section.title,
                    movies: section.movies,
                    thumbnailType: section.thumbnailType)
                .tabItem {
                    Text(section.title)
                        .foregroundColor(.white)
                }
            }
        }
        .task { loadMovies(invalidateCache: false) }
        .refreshable { loadMovies(invalidateCache: true) }
        .overlay(DataFetchPhaseOverlayView(
            phase: movieHomeState.phase,
            retryAction: { loadMovies(invalidateCache: true) })
        )
    }
        
    private func loadMovies(invalidateCache: Bool) {
        Task { await movieHomeState.loadMoviesFromAllEndpoints(invalidateCache: invalidateCache) }
    }
}

