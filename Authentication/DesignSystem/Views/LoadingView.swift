//
//  CustomLoadingView.swift
//  Authentication
//
//  Created by Лидия Некрасова on 30.04.2024.
//

import SwiftUI

struct LoadingView: View {
    
    // MARK: - Constants
    
    enum Constants {
        static let opacity: CGFloat = 0.8
        static let scaleEffect: CGFloat = 2
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .opacity(Constants.opacity)
                .ignoresSafeArea()
            
            ProgressView()
                .progressViewStyle(.circular)
                .scaleEffect(Constants.scaleEffect)
        }
    }
}

struct CustomLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
