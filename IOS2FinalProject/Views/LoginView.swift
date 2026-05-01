//
//  LoginView.swift
//  IOS2FinalProject
//
//  Created by Bartlett Powell on 4/29/26.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var auth: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var isSignUp = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Spacer()
                
                Image(systemName: "film")
                    .font(.system(size: 60))
                    .foregroundStyle(.blue)
                
                Text(isSignUp ? "Create Account" : "Movie Tracker")
                    .font(.largeTitle)
                    .bold()
                
                Text(isSignUp ? "Sign up to get started" : "Sign in to continue")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                
                VStack(spacing: 14) {
                    TextField("Email", text: $email)
                        .textFieldStyle(.roundedBorder)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.emailAddress)
                    
                    SecureField("Password", text: $password)
                        .textFieldStyle(.roundedBorder)
                }
                .padding(.horizontal)
                
                if let error = auth.errorMessage {
                    Text(error)
                        .font(.caption)
                        .foregroundStyle(.red)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                
                Button(action: {
                    if isSignUp {
                        auth.signUp(email: email, password: password)
                    } else {
                        auth.signIn(email: email, password: password)
                    }
                }) {
                    if auth.isLoading {
                        ProgressView()
                            .frame(maxWidth: .infinity, minHeight: 44)
                    } else {
                        Text(isSignUp ? "Sign Up" : "Sign In")
                            .font(.headline)
                            .frame(maxWidth: .infinity, minHeight: 44)
                    }
                }
                .background(Color.blue)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal)
                .disabled(email.isEmpty || password.isEmpty || auth.isLoading)
                
                Button(action: {
                    isSignUp.toggle()
                    auth.errorMessage = nil
                }) {
                    Text(isSignUp ? "Already have an account? Sign In" : "Don't have an account? Sign Up")
                        .font(.subheadline)
                        .foregroundStyle(.blue)
                }
                
                Spacer()
            }
        }
    }
}
