//
//  MovieThumbnailCarouselView.swift
//  MovieDevRev
//
//  Created by Anubhav Singh on 19/02/24.
//

import SwiftUI

struct MovieThumbnailCarouselView: View {
    
    let title: String
    let movies: [Movie]
    var thumbnailType: MovieThumbnailType = .poster()
    
    private let columns = [
        GridItem(.fixed((AppConstant.screenWidth - 48)/2), spacing: 16),
        GridItem(.fixed((AppConstant.screenWidth - 48)/2), spacing: 16)
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(self.movies) { movie in
                        NavigationLink(destination: MovieDetailView(movieId: movie.id, movieTitle: movie.title)) {
                            MovieThumbnailView(movie: movie, thumbnailType: thumbnailType)
                                .aspectRatio(9/16, contentMode: .fit)
                                .frame(height: 360)
                        }.buttonStyle(.plain)
                    }
                }
            }
        }
    }
}
