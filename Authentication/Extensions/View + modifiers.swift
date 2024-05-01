//
//  View + modifiers.swift
//  Authentication
//
//  Created by Лидия Некрасова on 30.04.2024.
//

import SwiftUI

extension View {
    
    func borderedTextFieldStyle(_ borderColor: Binding<Color>) -> some View {
        modifier(TextFieldModifier(borderColor: borderColor))
    }
    
    func mainTitleStyle() -> some View {
        modifier(TitleModifier())
    }
}
