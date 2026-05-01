//
//  SettingsView.swift
//  IOS2FinalProject
//
//  Created by Bartlett Powell on 4/29/26.
//

import SwiftUI
import FirebaseAuth
struct SettingsView: View {
    @EnvironmentObject var auth: AuthViewModel
    @EnvironmentObject var watchlistVM: WatchlistViewModel
    
    var body: some View {
        NavigationStack {
            List {
                Section("Account") {
                    if let email = auth.user?.email {
                        HStack {
                            Text("Email")
                            Spacer()
                            Text(email)
                                .foregroundStyle(.gray)
                        }
                    }
                    
                    HStack {
                        Text("Watchlist Items")
                        Spacer()
                        Text("\(watchlistVM.watchlist.count)")
                            .foregroundStyle(.gray)
                    }
                }
                
                Section {
                    Button(action: {
                        auth.signOut()
                    }) {
                        HStack {
                            Spacer()
                            Text("Sign Out")
                                .foregroundStyle(.red)
                            Spacer()
                        }
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}
 
