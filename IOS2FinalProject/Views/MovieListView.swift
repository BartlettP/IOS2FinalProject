//
//  MovieListView.swift
//  IOS2FinalProject
//
//  Created by Bartlett Powell on 4/29/26.
//

import SwiftUI
 
struct MovieListView: View {
    @StateObject private var viewModel = MovieViewModel()
    @EnvironmentObject var watchlistVM: WatchlistViewModel
    
    var body: some View {
        NavigationStack {
            List(viewModel.movies) { movie in
                NavigationLink(destination: MovieDetailView(movie: movie)) {
                    HStack(spacing: 12) {
                        AsyncImage(url: movie.posterURL) { image in
                            image.resizable()
                        } placeholder: {
                            Rectangle()
                                .fill(Color.gray.opacity(0.3))
                        }
                        .frame(width: 60, height: 90)
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(movie.title)
                                .font(.headline)
                                .lineLimit(2)
                            
                            if let date = movie.releaseDate {
                                Text(date)
                                    .font(.caption)
                                    .foregroundStyle(.gray)
                            }
                            
                            HStack(spacing: 4) {
                                Image(systemName: "star.fill")
                                    .foregroundStyle(.yellow)
                                    .font(.caption)
                                Text(movie.formattedRating)
                                    .font(.caption)
                                    .foregroundStyle(.gray)
                            }
                        }
                    }
                    .padding(.vertical, 4)
                }
            }
            .navigationTitle("Movies")
            .searchable(text: $viewModel.searchText, prompt: "Search movies")
            .onChange(of: viewModel.searchText) { oldValue, newValue in
                if newValue.isEmpty {
                    viewModel.fetchPopularMovies()
                } else {
                    viewModel.searchMovies(query: newValue)
                }
            }
            .onAppear {
                if viewModel.movies.isEmpty {
                    viewModel.fetchPopularMovies()
                }
            }
        }
    }
}
