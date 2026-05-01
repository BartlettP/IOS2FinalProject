//
//  MovieViewModel.swift
//  IOS2FinalProject
//
//  Created by Bartlett Powell on 4/29/26.
//

import Foundation
import Combine

class MovieViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var searchText: String = ""
    @Published var isLoading = false
    
    private let apiKey = "92f03068a110539fd8d690689a8f6dda"
    
    func fetchPopularMovies() {
        isLoading = true
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            
            if let decoded = try? JSONDecoder().decode(MovieResponse.self, from: data) {
                DispatchQueue.main.async {
                    self.movies = decoded.results
                    self.isLoading = false
                }
            }
        }.resume()
    }
    
    func searchMovies(query: String) {
        guard !query.isEmpty else {
            fetchPopularMovies()
            return
        }
        
        isLoading = true
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? query
        guard let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&query=\(encodedQuery)") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            
            if let decoded = try? JSONDecoder().decode(MovieResponse.self, from: data) {
                DispatchQueue.main.async {
                    self.movies = decoded.results
                    self.isLoading = false
                }
            }
        }.resume()
    }
}
