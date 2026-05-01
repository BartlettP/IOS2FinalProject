//
//  AuthViewModel.swift
//  IOS2FinalProject
//
//  Created by Bartlett Powell on 4/29/26.
//

import Foundation
import FirebaseAuth
import Combine
 
class AuthViewModel: ObservableObject {
    @Published var user: User?
    @Published var errorMessage: String?
    @Published var isLoading = false
    
    private var authStateListener: AuthStateDidChangeListenerHandle?
    
    init() {
        authStateListener = Auth.auth().addStateDidChangeListener { _, user in
            self.user = user
        }
    }
    
    var isSignedIn: Bool {
        user != nil
    }
    
    func signUp(email: String, password: String) {
        isLoading = true
        errorMessage = nil
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            DispatchQueue.main.async {
                self.isLoading = false
                if let error = error {
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func signIn(email: String, password: String) {
        isLoading = true
        errorMessage = nil
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            DispatchQueue.main.async {
                self.isLoading = false
                if let error = error {
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
 






