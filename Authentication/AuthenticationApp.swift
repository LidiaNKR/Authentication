//
//  AuthenticationApp.swift
//  Authentication
//
//  Created by Лидия Некрасова on 29.04.2024.
//

import SwiftUI
import Firebase

@main
struct AuthenticationApp: App {
    
    // MARK: - Properties
    
    @StateObject private var viewModel = AuthenticationViewModel()
    
    // MARK: - Initializers
    
    init() {
      setupAuthentication()
    }
    
    // MARK: - Body
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}

// MARK: - Extension

extension AuthenticationApp {
    
  private func setupAuthentication() {
    FirebaseApp.configure()
  }
    
}
