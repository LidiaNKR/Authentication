//
//  LoginHeader.swift
//  Authentication
//
//  Created by Лидия Некрасова on 30.04.2024.
//

import SwiftUI

struct LoginHeader: View {
    
    // MARK: - Properties
    
    let title: LocalizedStringKey
    let text: LocalizedStringKey
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            Text(title)
                .mainTitleStyle()
            
            Text(text)
                .multilineTextAlignment(.center)
        }
    }
}

struct LoginHeader_Previews: PreviewProvider {
    static var previews: some View {
        LoginHeader(title: "Login to your personal account",
                    text: "Please login to continue")
    }
}
