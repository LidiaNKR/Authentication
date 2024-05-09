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
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showRegistrationView: Bool = false
    @State private var showResetPasswordView: Bool = false
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    VStack(alignment: .center) {
                        
                        //Заголовок
                        LoginHeader(title: "Login to your personal account",
                                    text: "Please login to continue")
                            .padding(.bottom)
                        
                        //Поле ввода эл. почты
                        EmailTextField(title: "Enter your E-mail",
                                       text: $email)
                        
                        //Поле ввода пароля
                        PasswordSecureField(title: "Enter your password",
                                            text: $password,
                                            isValidPassword: .constant(false))
                        
                        HStack {
                            //Зарегистрироваться
                            Button("Register") {
                                showRegistrationView.toggle()
                            }
                            Spacer()
                            
                            //Сбросить пароль
                            Button("Forgot your password?") {
                                showResetPasswordView.toggle()
                            }
                        }
                        .padding(.horizontal,
                                 Constants.buttonsHorisontalPadding)
                        
                        //Войти
                        MainButton(title: "Login") {
                            
                            viewModel.showLoadingView.toggle()
                            
                            Task {
                                try await viewModel.signIn(withEmail: email,
                                                           password: password)
                            }
                        }
                        
                        HStack {
                            VStack {
                                Divider()
                            }
                            Text("or")
                            VStack {
                                Divider()
                            }
                        }
                        
                        //Вход через Google
                        GoogleButton(title: "Sign in with Google") {
                            viewModel.signInWithGoogle()
                        }
                    }
                    //Алерт
                    .alert(isPresented: $viewModel.showAlert) {
                        Alert(title: Text("Error"),
                              message: Text(viewModel.message),
                              dismissButton:
                                .default(Text("Ok")) {
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
