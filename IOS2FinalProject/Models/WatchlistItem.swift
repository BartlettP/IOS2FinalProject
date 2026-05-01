//
//  WatchlistItem.swift
//  IOS2FinalProject
//
//  Created by Bartlett Powell on 4/29/26.
//

import Foundation
 
struct WatchlistItem: Identifiable, Codable {
    var id: Int
    var title: String
    var posterPath: String?
    var overview: String
    var voteAverage: Double
    var releaseDate: String?
    var userRating: Int
    
    var posterURL: URL? {
        guard let posterPath = posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
    }
    
    var formattedRating: String {
        String(format: "%.1f", voteAverage)
    }
}
 
