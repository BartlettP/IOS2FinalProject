//
//  MovieDetailView.swift
//  IOS2FinalProject
//
//  Created by Bartlett Powell on 4/29/26.
//

import SwiftUI

struct MovieDetailView: View {
    let movie: Movie
    @EnvironmentObject var watchlistVM: WatchlistViewModel
    @State private var selectedRating: Int = 0
    @State private var showAddedAlert = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                AsyncImage(url: movie.posterURL) { image in
                    image.resizable()
                } placeholder: {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                }
                .frame(width: 200, height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                
                Text(movie.title)
                    .font(.title)
                    .bold()
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                HStack(spacing: 16) {
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .foregroundStyle(.yellow)
                        Text(movie.formattedRating + " / 10")
                            .font(.subheadline)
                    }
                    
                    if let date = movie.releaseDate {
                        Text(date)
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                    }
                }
                
                Text(movie.overview)
                    .font(.body)
                    .padding(.horizontal)
                
                VStack(spacing: 12) {
                    Text("Your Rating")
                        .font(.headline)
                    
                    HStack(spacing: 8) {
                        ForEach(1...5, id: \.self) { star in
                            Image(systemName: star <= selectedRating ? "star.fill" : "star")
                                .font(.title2)
                                .foregroundStyle(star <= selectedRating ? .yellow : .gray)
                                .onTapGesture {
                                    selectedRating = star
                                }
                        }
                    }
                }
                .padding()
                
                if watchlistVM.isInWatchlist(movieID: movie.id) {
                    Button(action: {
                        watchlistVM.removeFromWatchlist(movieID: movie.id)
                    }) {
                        Text("Remove from Watchlist")
                            .font(.headline)
                            .frame(maxWidth: .infinity, minHeight: 44)
                    }
                    .background(Color.red)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.horizontal)
                } else {
                    Button(action: {
                        watchlistVM.addToWatchlist(movie: movie, rating: selectedRating)
                        showAddedAlert = true
                    }) {
                        Text("Add to Watchlist")
                            .font(.headline)
                            .frame(maxWidth: .infinity, minHeight: 44)
                    }
                    .background(Color.blue)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.horizontal)
                }
            }
            .padding(.vertical)
        }
        .navigationTitle(movie.title)
        .navigationBarTitleDisplayMode(.inline)
        .alert("Added!", isPresented: $showAddedAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("\(movie.title) has been added to your watchlist.")
        }
        .onAppear {
            if let item = watchlistVM.watchlist.first(where: { $0.id == movie.id }) {
                selectedRating = item.userRating
            }
        }
    }
}
