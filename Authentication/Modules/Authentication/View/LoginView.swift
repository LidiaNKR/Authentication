//
//  LoginView.swift
//  Authentication
//
//  Created by Лидия Некрасова on 29.04.2024.
//

import SwiftUI

struct LoginView: View {
    
    // MARK: - Constants
    
    enum Constants {
        static let buttonsHorisontalPadding: CGFloat = 16
    }
    
    // MARK: - Properties
    
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    @State var email: String = ""
    @State var password: String = ""
    @State var showRegistrationView: Bool = false
    @State var showResetPasswordView: Bool = false
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    VStack(alignment: .center) {
                        
                        LoginHeader(title: L10n.loginTitle,
                                    text: L10n.loginText)
                            .padding(.bottom)
                        
                        EmailTextField(title: L10n.enterEmailTitle,
                                       text: $email)
                        
                        PasswordSecureField(title: L10n.enterPasswordTitle,
                                            text: $password,
                                            isValidPassword: .constant(false))
                        
                        HStack {
                            Button(L10n.signUp) {
                                showRegistrationView.toggle()
                            }
                            Spacer()
                            Button(L10n.forgotPassword) {
                                showResetPasswordView.toggle()
                            }
                        }
                        .padding(.horizontal, Constants.buttonsHorisontalPadding)
                        
                        MainButton(title: L10n.loginButtonTitle) {
                            
                            viewModel.showLoadingView.toggle()
                            
                            Task {
                                try await viewModel.signIn(withEmail: email, password: password)
                            }
                        }
                        
                        HStack {
                            VStack {
                                Divider()
                            }
                            Text(L10n.or)
                            VStack {
                                Divider()
                            }
                        }
                        
                        GoogleButton(title: L10n.googleButtonTitle) {
                            viewModel.signInWithGoogle()
                        }
                    }
                    .alert(isPresented: $viewModel.showAlert) {
                        Alert(title: Text(L10n.alertTitle), message: Text(viewModel.message),
                              dismissButton: .default(Text(L10n.alertButtonTitle)) {
                            viewModel.showLoadingView.toggle()
                        })
                    }
                    .padding(.horizontal)
                }
                
                if viewModel.showLoadingView {
                    LoadingView()
                }
            }
        }
        .sheet(isPresented: $showRegistrationView) {
            RegistrationView()
        }
        .sheet(isPresented: $showResetPasswordView) {
            ResetPasswordView()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
