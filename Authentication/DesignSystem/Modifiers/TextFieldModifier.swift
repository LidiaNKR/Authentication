//
//  TextFieldModifier.swift
//  Authentication
//
//  Created by Лидия Некрасова on 30.04.2024.
//

import SwiftUI

struct TextFieldModifier: ViewModifier {
    
    // MARK: - Constants
    
    enum Constants {
        static let lineWidth: CGFloat = 1
        static let cornerRadius: CGFloat = 12
    }
    
    // MARK: - Properties
    
    @Binding var borderColor: Color
    
    // MARK: - Body
    
    func body(content: Content) -> some View {
        content
            .disableAutocorrection(true)
            .autocapitalization(.none)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: Constants.cornerRadius)
                    .stroke(borderColor, lineWidth: Constants.lineWidth))
    }
}
