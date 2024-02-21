//
//  MovieDetailView.swift
//  MovieDevRev
//
//  Created by Anubhav Singh on 19/02/24.
//

import SwiftUI

struct MovieDetailView: View {
    
    let movieId: Int
    let movieTitle: String
    @StateObject private var movieDetailState = MovieDetailState()
    @State private var selectedTrailerURL: URL?
    @StateObject var imageLoader = ImageLoader()
    
    var body: some View {
        List {
            if let movie = movieDetailState.movie {
                MovieDetailImage(imageURL: movie.popularURL)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    .aspectRatio(16/9, contentMode: .fill)
                    .listRowSeparator(.hidden)
                    
                MovieDetailListView(movie: movie, selectedTrailerURL: $selectedTrailerURL)
            }
        }
        .listStyle(.plain)
        .task(loadMovie)
        .overlay(DataFetchPhaseOverlayView(
            phase: movieDetailState.phase,
            retryAction: loadMovie)
        )
        .sheet(item: $selectedTrailerURL) { SafariView(url: $0).edgesIgnoringSafeArea(.bottom)}
        .navigationTitle(movieTitle)
    }
    
    @Sendable
    private func loadMovie() {
        Task { await self.movieDetailState.loadMovie(id: self.movieId) }
    }
}

struct MovieDetailListView: View {
    let movie: Movie
    @Binding var selectedTrailerURL: URL?
    @StateObject private var movieDetailState = MovieDetailState()
    var body: some View {
        movieDescriptionSection.listRowSeparator(.visible)
        movieCastSection.listRowSeparator(.hidden)
        movieTrailerSection
    }
    
    private var movieDescriptionSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                MovieDetailImage(imageURL: movie.latestURL)
                    .aspectRatio(9/16, contentMode: .fit)
                    .frame(height: 120)
                Spacer()
                HStack {
                    if !movie.ratingText.isEmpty {
                        Text(movie.ratingText).foregroundColor(.yellow)
                    }
                    Text(movie.scoreText)
                }.padding(.horizontal, 4)
                .background(Color.white)
                .cornerRadius(3.0)
            }.offset(y: -42)
            .frame(height: 30)
            Text(movieGenreYearDurationText)
                .font(.headline)
                .listRowSeparator(.hidden)
            Text(movie.overview)
        }
        .padding(.vertical)
    }
    
    private var movieCastSection: some View {
        HStack(alignment: .top, spacing: 4) {
            if let cast = movie.cast, !cast.isEmpty {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Starring").font(.headline)
                    ForEach(cast.prefix(9)) { Text($0.name) }
                }
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                Spacer()
                
            }
            
            if let crew = movie.crew, !crew.isEmpty {
                VStack(alignment: .leading, spacing: 4) {
                    if let directors = movie.directors, !directors.isEmpty {
                        Text("Director(s)").font(.headline)
                        ForEach(directors.prefix(2)) { Text($0.name) }
                    }
                    
                    if let producers = movie.producers, !producers.isEmpty {
                        Text("Producer(s)").font(.headline)
                            .padding(.top)
                        ForEach(producers.prefix(2)) { Text($0.name) }
                    }
                    
                    if let screenwriters = movie.screenWriters, !screenwriters.isEmpty {
                        Text("Screenwriter(s)").font(.headline)
                            .padding(.top)
                        ForEach(screenwriters.prefix(2)) { Text($0.name) }
                    }
                }
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding(.vertical)
    }
    
    @ViewBuilder
    private var movieTrailerSection: some View {
        if let trailers = movie.youtubeTrailers, !trailers.isEmpty {
            Text("Trailers").font(.headline)
            ForEach(trailers) { trailer in
                Button(action: {
                    guard let url = trailer.youtubeURL else { return }
                    selectedTrailerURL = url
                }) {
                    HStack {
                        Text(trailer.name)
                        Spacer()
                        Image(systemName: "play.circle.fill")
                            .foregroundColor(Color(UIColor.systemBlue))
                    }
                }
            }
        }
    }
    
    
    private var movieGenreYearDurationText: String {
        "\(movie.genreText) · \(movie.yearText) · \(movie.durationText)"
    }
}

struct MovieDetailImage: View {
    
    @StateObject private var imageLoader = ImageLoader()
    let imageURL: URL
    
    var body: some View {
        VStack{
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
                    .cornerRadius(3)
            }
        }.cornerRadius(3)
        .onAppear { imageLoader.loadImage(with: imageURL) }
    }
}

extension URL: Identifiable {
    
    public var id: Self { self }
}
