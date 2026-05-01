//
//  WatchlistViewModel.swift
//  IOS2FinalProject
//
//  Created by Bartlett Powell on 4/29/26.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import Combine
 
class WatchlistViewModel: ObservableObject {
    @Published var watchlist: [WatchlistItem] = []
    
    private let db = Firestore.firestore()
    
    private var userID: String? {
        Auth.auth().currentUser?.uid
    }
    
    func addToWatchlist(movie: Movie, rating: Int = 0) {
        guard let userID = userID else { return }
        
        let item = WatchlistItem(
            id: movie.id,
            title: movie.title,
            posterPath: movie.posterPath,
            overview: movie.overview,
            voteAverage: movie.voteAverage,
            releaseDate: movie.releaseDate,
            userRating: rating
        )
        
        let data: [String: Any] = [
            "id": item.id,
            "title": item.title,
            "posterPath": item.posterPath ?? "",
            "overview": item.overview,
            "voteAverage": item.voteAverage,
            "releaseDate": item.releaseDate ?? "",
            "userRating": item.userRating
        ]
        
        db.collection("users").document(userID).collection("watchlist").document("\(movie.id)").setData(data) { error in
            if error == nil {
                self.fetchWatchlist()
            }
        }
    }
    
    func removeFromWatchlist(movieID: Int) {
        guard let userID = userID else { return }
        
        db.collection("users").document(userID).collection("watchlist").document("\(movieID)").delete { error in
            if error == nil {
                DispatchQueue.main.async {
                    self.watchlist.removeAll { $0.id == movieID }
                }
            }
        }
    }
    
    func updateRating(movieID: Int, rating: Int) {
        guard let userID = userID else { return }
        
        db.collection("users").document(userID).collection("watchlist").document("\(movieID)").updateData(["userRating": rating]) { error in
            if error == nil {
                DispatchQueue.main.async {
                    if let index = self.watchlist.firstIndex(where: { $0.id == movieID }) {
                        self.watchlist[index].userRating = rating
                    }
                }
            }
        }
    }
    
    func isInWatchlist(movieID: Int) -> Bool {
        watchlist.contains { $0.id == movieID }
    }
    
    func fetchWatchlist() {
        guard let userID = userID else { return }
        
        db.collection("users").document(userID).collection("watchlist").getDocuments { snapshot, error in
            guard let documents = snapshot?.documents, error == nil else { return }
            
            DispatchQueue.main.async {
                self.watchlist = documents.compactMap { doc in
                    let data = doc.data()
                    return WatchlistItem(
                        id: data["id"] as? Int ?? 0,
                        title: data["title"] as? String ?? "",
                        posterPath: data["posterPath"] as? String,
                        overview: data["overview"] as? String ?? "",
                        voteAverage: data["voteAverage"] as? Double ?? 0.0,
                        releaseDate: data["releaseDate"] as? String,
                        userRating: data["userRating"] as? Int ?? 0
                    )
                }
            }
        }
    }
}
 
