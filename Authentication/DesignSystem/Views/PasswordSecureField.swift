//
//  PasswordSecureField.swift
//  Authentication
//
//  Created by Лидия Некрасова on 30.04.2024.
//

import SwiftUI

struct PasswordSecureField: View {
    
    // MARK: - Properties
    
    @Binding private var text: String
    @Binding private var isValidPassword: Bool
    @State private var borderColor: Color = .primaryColor
    @State private var isSecured: Bool = true
    
    private let title: String
    private var ifNeedCheckValidation: Bool = false
    
    // MARK: - Initializers
    
    init(title: String,
         text: Binding<String>,
         isValidPassword: Binding<Bool>,
         ifNeedCheckValidation: Bool = false) {
        self.title = title
        self._text = text
        self._isValidPassword = isValidPassword
        self.ifNeedCheckValidation = ifNeedCheckValidation
    }
    
    // MARK: - Body
    
    var body: some View {
        HStack {
            Image(systemName: "lock")
            
            Group {
                if isSecured {
                    SecureField(title, text: $text)
                } else {
                    TextField(title, text: $text)
                }
            }
            .onChange(of: text) { _ in
                if !text.isEmpty && ifNeedCheckValidation {
                    borderColor = isValidPassword ? .green : .red
                } else {
                    borderColor = .primaryColor
                }
            }
            
            Spacer()
            
            if !text.isEmpty {
                Button(action: {
                    isSecured.toggle()
                }) {
                    Image(systemName: isSecured ? "eye.slash" : "eye")
                        .accentColor(.gray)
                }
            }
        }
        .borderedTextFieldStyle($borderColor)
    }
}

struct PasswordSecureField_Previews: PreviewProvider {
    static var previews: some View {
        PasswordSecureField(title: L10n.enterPasswordTitle,
                          text: .constant(""),
                          isValidPassword: .constant(true))
    }
}
