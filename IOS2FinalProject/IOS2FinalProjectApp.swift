//
//  IOS2FinalProjectApp.swift
//  IOS2FinalProject
//
//  Created by Bartlett Powell on 4/29/26.
//

import SwiftUI
import FirebaseCore
 
@main
struct IOS2FinalProjectApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    @StateObject private var authVM = AuthViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authVM)
        }
    }
}
 






