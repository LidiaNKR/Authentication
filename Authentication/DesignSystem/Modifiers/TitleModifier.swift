//
//  TitleModifier.swift
//  Authentication
//
//  Created by Лидия Некрасова on 01.05.2024.
//

import SwiftUI

struct TitleModifier: ViewModifier {
    
    // MARK: - Body
    
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .fontWeight(.medium)
            .multilineTextAlignment(.center)
            .padding()
    }
}
