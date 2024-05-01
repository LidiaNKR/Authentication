//
//  EmailTextfield.swift
//  Authentication
//
//  Created by Лидия Некрасова on 30.04.2024.
//

import SwiftUI

struct EmailTextField: View {
    
    // MARK: - Properties
    
    @State private var borderColor: Color = .primaryColor
    @Binding private var text: String
    private let title: String
    
    // MARK: - Initializers
    
    init(title: String, text: Binding<String>) {
        self.title = title
        self._text = text
    }
    
    // MARK: - Body
    
    var body: some View {
        HStack {
            Image(systemName: "mail")
            
            TextField(title, text: $text)
                .textContentType(.emailAddress)
                .onChange(of: text) { _ in
                    if !text.isEmpty {
                        borderColor = text.isValidEmail ? .green : .red
                    } else {
                        borderColor = .primaryColor
                    }
                }
            
            Spacer()
            
            if !text.isEmpty {
                Button(action: {
                    text = ""
                }) {
                    Image(systemName: "delete.left.fill")
                        .foregroundColor(.gray)
                }
            }
        }
        .borderedTextFieldStyle($borderColor)
    }
}

struct EmailTextfield_Previews: PreviewProvider {
    static var previews: some View {
        EmailTextField(title: L10n.enterEmailTitle,
                       text: .constant(""))
    }
}
