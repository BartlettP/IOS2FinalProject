//
//  MovieModel.swift
//  IOS2FinalProject
//
//  Created by Bartlett Powell on 4/29/26.
//


import Foundation
 
struct MovieResponse: Codable {
    let results: [Movie]
}
 
struct Movie: Codable, Identifiable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let voteAverage: Double
    let releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
    }
    
    var posterURL: URL? {
        guard let posterPath = posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
    }
    
    var formattedRating: String {
        String(format: "%.1f", voteAverage)
    }
}
 






