//
//  WatchlistView.swift
//  IOS2FinalProject
//
//  Created by Bartlett Powell on 4/29/26.
//

import SwiftUI
 
struct WatchlistView: View {
    @EnvironmentObject var watchlistVM: WatchlistViewModel
    
    var body: some View {
        NavigationStack {
            Group {
                if watchlistVM.watchlist.isEmpty {
                    VStack(spacing: 16) {
                        Spacer()
                        Image(systemName: "film.stack")
                            .font(.system(size: 50))
                            .foregroundStyle(.gray)
                        Text("Your watchlist is empty")
                            .font(.title3)
                            .foregroundStyle(.gray)
                        Text("Browse movies and add them to your watchlist")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                        Spacer()
                    }
                } else {
                    List {
                        ForEach(watchlistVM.watchlist) { item in
                            HStack(spacing: 12) {
                                AsyncImage(url: item.posterURL) { image in
                                    image.resizable()
                                } placeholder: {
                                    Rectangle()
                                        .fill(Color.gray.opacity(0.3))
                                }
                                .frame(width: 50, height: 75)
                                .clipShape(RoundedRectangle(cornerRadius: 6))
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(item.title)
                                        .font(.headline)
                                        .lineLimit(2)
                                    
                                    HStack(spacing: 4) {
                                        Image(systemName: "star.fill")
                                            .foregroundStyle(.yellow)
                                            .font(.caption)
                                        Text("TMDB: \(item.formattedRating)")
                                            .font(.caption)
                                            .foregroundStyle(.gray)
                                    }
                                    
                                    if item.userRating > 0 {
                                        HStack(spacing: 2) {
                                            ForEach(1...5, id: \.self) { star in
                                                Image(systemName: star <= item.userRating ? "star.fill" : "star")
                                                    .font(.caption2)
                                                    .foregroundStyle(star <= item.userRating ? .yellow : .gray)
                                            }
                                            Text("(Your rating)")
                                                .font(.caption2)
                                                .foregroundStyle(.gray)
                                        }
                                    }
                                }
                                
                                Spacer()
                                
                                Button(action: {
                                    watchlistVM.removeFromWatchlist(movieID: item.id)
                                }) {
                                    Image(systemName: "trash")
                                        .foregroundStyle(.red)
                                }
                                .buttonStyle(.plain)
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }
            }
            .navigationTitle("Watchlist")
            .onAppear {
                watchlistVM.fetchWatchlist()
            }
        }
    }
}
 
