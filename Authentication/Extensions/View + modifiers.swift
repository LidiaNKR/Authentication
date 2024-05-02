//
//  View + modifiers.swift
//  Authentication
//
//  Created by Лидия Некрасова on 30.04.2024.
//

import SwiftUI

extension View {
    
    //Текстовое поле с границей
    func borderedTextFieldStyle(_ borderColor: Binding<Color>) -> some View {
        modifier(TextFieldModifier(borderColor: borderColor))
    }
    
    //Стиль заголовка
    func mainTitleStyle() -> some View {
        modifier(TitleModifier())
    }
}
