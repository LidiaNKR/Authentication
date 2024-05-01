//
//  MainButton.swift
//  Authentication
//
//  Created by Лидия Некрасова on 30.04.2024.
//

import SwiftUI

struct MainButton: View {
    
    // MARK: - Constants
    
    enum Constants {
        static let cornerRadius: CGFloat = 12
    }
    
    // MARK: - Properties
    
    var title: String
    var action: () -> Void
    
    // MARK: - Body
    
    var body: some View {
        Button(action: {
            action()
        }) {
            HStack {
                Spacer()
                Text(title)
                    .foregroundColor(.white)
                Spacer()
            }
        }
        .padding()
        .background(.green)
        .cornerRadius(Constants.cornerRadius)
        .padding(.vertical)
    }
}

struct MainButton_Previews: PreviewProvider {
    static var previews: some View {
        MainButton(title: L10n.loginButtonTitle, action: {})
    }
}
