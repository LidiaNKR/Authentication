//
//  TextBox.swift
//  Authentication
//
//  Created by Лидия Некрасова on 01.05.2024.
//

import SwiftUI

struct TextBox: Identifiable {
    
    var id = UUID().uuidString
    var text: String = ""
    var isBold: Bool = false
    var offset: CGSize = .zero
    var lastOffset: CGSize = .zero
    var textColor: Color = .white
    var isAdded: Bool = false
}
