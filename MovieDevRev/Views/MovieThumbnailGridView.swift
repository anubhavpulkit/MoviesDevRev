//
//  MovieThumbnailCarouselView.swift
//  MovieDevRev
//
//  Created by Anubhav Singh on 19/02/24.
//

import Foundation
import SwiftUI

struct MovieThumbnailGridView: View {
    
    let title: String
    let movies: [Movie]
    var thumbnailType: MovieThumbnailType = .latest()
    
    private let columns = [
        GridItem(.fixed(AppConstant.screenWidth * 0.45), spacing: 16),
        GridItem(.fixed(AppConstant.screenWidth * 0.45), spacing: 16)
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(self.movies) { movie in
                        NavigationLink(destination: MovieDetailView(movieId: movie.id, movieTitle: movie.title)) {
                            MovieThumbnailView(movie: movie, thumbnailType: thumbnailType)
                                .movieThumbnailViewFrame(thumbnailType: thumbnailType)
                        }.buttonStyle(.plain)
                    }
                }
            }
        }
    }
}

fileprivate extension View {
    
    @ViewBuilder
    func movieThumbnailViewFrame(thumbnailType: MovieThumbnailType) -> some View {
        switch thumbnailType {
        case .latest:
            self.aspectRatio(9/16, contentMode: .fit)
                .frame(height: 360)
        case .popular:
            self
                .aspectRatio(16/11, contentMode: .fit)
                .frame(height: 140)
        }
    }
}
