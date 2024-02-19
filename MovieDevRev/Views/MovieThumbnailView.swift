//
//  MovieThumbnailView.swift
//  MovieDevRev
//
//  Created by Anubhav Singh on 18/02/24.
//

import SwiftUI

enum MovieThumbnailType {
    case poster(showTitle: Bool = true)
    case backdrop
}

struct MovieThumbnailView: View {
    let movie: Movie
    var thumbnailType: MovieThumbnailType = .poster()
    @StateObject var imageLoader = ImageLoader()
    
    var body: some View {
        containerView
            .onAppear {
                switch thumbnailType {
                case .poster:
                    imageLoader.loadImage(with: movie.posterURL)
                case .backdrop:
                    imageLoader.loadImage(with: movie.backdropURL)
                }
            }
    }
    
    @ViewBuilder
    private var containerView: some View {
        VStack(alignment: .leading, spacing: 8){
            imageView
            textView
        }
    }
    
    private var textView: some View {
        HStack{
            Text(movie.title + " :")
            if case .poster(let showTitle) = thumbnailType {
                Text(movie.yearText)
            } else {
                Text(movie.scoreText)
            }
        }.font(.footnote)
    }
    
    private var imageView: some View {
        ZStack {
            Color.gray.opacity(0.3)
            if case .poster(let showTitle) = thumbnailType, showTitle {
                Text(movie.title)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .lineLimit(4)
            }
            
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .layoutPriority(-1)
            }
        }
        .cornerRadius(8)
        .shadow(radius: 4)
    }
}
