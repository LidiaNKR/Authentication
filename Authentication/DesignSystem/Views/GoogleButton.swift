//
//  GoogleButton.swift
//  Authentication
//
//  Created by Лидия Некрасова on 29.04.2024.
//

import SwiftUI

/// Кнопка входа через учетную запись Google
struct GoogleButton: View {
    
    // MARK: - Constants
    
    enum Constants {
        static let imageSize: CGFloat = 20
        static let cornerRadius: CGFloat = 12
    }
    
    // MARK: - Properties
    
    let title: String
    var action: () -> Void
    
    // MARK: - Body
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Spacer()
                
                Image(asset: Assets.google)
                    .resizable()
                    .frame(width: Constants.imageSize,
                           height: Constants.imageSize)
                
                Text(title)
                    .foregroundColor(.primaryColor)
                
                Spacer()
            }
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: Constants.cornerRadius)
                .stroke()
        )
        .padding(.vertical)
    }
}

struct GoogleButton_Previews: PreviewProvider {
    static var previews: some View {
        GoogleButton(title: L10n.googleButtonTitle, action: {})
    }
}
