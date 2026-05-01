//
//  ContentView.swift
//  IOS2FinalProject
//
//  Created by Bartlett Powell on 4/29/26.
//

import SwiftUI
 
struct ContentView: View {
    @EnvironmentObject var auth: AuthViewModel
    @StateObject private var watchlistVM = WatchlistViewModel()
    
    var body: some View {
        if auth.isSignedIn {
            TabView {
                MovieListView()
                    .tabItem {
                        Image(systemName: "film")
                        Text("Movies")
                    }
                
                WatchlistView()
                    .tabItem {
                        Image(systemName: "bookmark.fill")
                        Text("Watchlist")
                    }
                
                SettingsView()
                    .tabItem {
                        Image(systemName: "gear")
                        Text("Settings")
                    }
            }
            .environmentObject(watchlistVM)
            .onAppear {
                watchlistVM.fetchWatchlist()
            }
        } else {
            LoginView()
        }
    }
}
 
