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
    @StateObject var viewModel = AuthenticationViewModel()
    
    init() {
      setupAuthentication()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}

extension AuthenticationApp {
  private func setupAuthentication() {
    FirebaseApp.configure()
  }
}
