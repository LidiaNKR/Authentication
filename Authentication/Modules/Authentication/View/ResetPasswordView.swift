//
//  ResetPasswordView.swift
//  Authentication
//
//  Created by Лидия Некрасова on 29.04.2024.
//

import SwiftUI

struct ResetPasswordView: View {
    
    // MARK: - Navigation
    
    @Environment(\.presentationMode) var presentationMode
    
    // MARK: - Properties
    
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    @State var email: String = ""
    @State var message: String = ""
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            VStack {
                Text(L10n.resetPassword)
                    .mainTitleStyle()
                
                EmailTextField(title: L10n.enterEmailTitle,
                                text: $email)
                
                MainButton(title: L10n.resetPasswordButtonTitle) {
                    
                    viewModel.showLoadingView.toggle()
                    
                    Task {
                        try await viewModel.resetPassword(email: email)
                    }
                }
                .padding(.top)
                
                .alert(isPresented: $viewModel.showAlert) {
                    
                    Alert(title:
                            Text(viewModel.isDismissView ? L10n.alertSuccessResetPasswordTitle : L10n.alertTitle),
                          message: Text(message),
                          dismissButton: .default(Text(L10n.alertButtonTitle)) {
                        if viewModel.isDismissView {
                            presentationMode.animation().wrappedValue.dismiss()
                        }
                        viewModel.showLoadingView.toggle()
                    })
                }
            }
            .padding(.horizontal)
            
            if viewModel.showLoadingView {
                LoadingView()
            }
        }
    }
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
    }
}

