//
//  Color.swift
//  Authentication
//
//  Created by Лидия Некрасова on 02.05.2024.
//

import SwiftUI

extension Color {
    
    /// Белый/Черный
    static var primaryColor: Color {
        Color(
            UIColor {
                $0.userInterfaceStyle == .dark ? .white : .black
            }
        )
    }
}
