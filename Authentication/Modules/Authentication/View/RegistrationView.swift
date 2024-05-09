//
//  RegistrationView.swift
//  Authentication
//
//  Created by Лидия Некрасова on 29.04.2024.
//

import SwiftUI

struct RegistrationView: View {
    
    // MARK: - Navigation
    
    @Environment(\.presentationMode) private var presentationMode
    
    // MARK: - Properties
    
    @EnvironmentObject private var viewModel: AuthenticationViewModel
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var passwordAgain: String = ""
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            VStack() {
                
                Spacer()
                
                //Заголовок
                Text("Registration")
                    .mainTitleStyle()
                
                //Поле ввода эл. почты
                EmailTextField(title: "Enter your E-mail",
                               text: $username)
                
                //Поле ввода пароля
                PasswordSecureField(title: "Enter your password",
                                    text: $password,
                                    isValidPassword: Binding(
                                        get: { self.password.isValidPassword },
                                        set: {_ in }
                                    ),
                                    ifNeedCheckValidation: true)
                
                //Поле подтверждения пароля
                PasswordSecureField(title: "Confirm password",
                                    text: $passwordAgain,
                                    isValidPassword: Binding(
                                        get: { self.password == self.passwordAgain },
                                        set: {_ in }
                                    ),
                                    ifNeedCheckValidation: true)
                
                //Регистрация
                MainButton(title: "Register") {
                    viewModel.showLoadingView.toggle()

                    Task {
                        try await viewModel.signUp(withEmail: username, 
                                                   password: password)
                    }
                }
                .padding(.top)
                
                //Алерт
                .alert(isPresented: $viewModel.showAlert) {
                    Alert(title: Text(viewModel.isDismissView 
                                      ? "Registration completed successfully"
                                      : "Error"),
                          message: Text(viewModel.message),
                          dismissButton: .default(Text("Ok")) {
                        if viewModel.isDismissView { 
                            presentationMode.animation().wrappedValue.dismiss()
                        }
                        viewModel.showLoadingView.toggle()
                    })
                }
                
                Spacer()
                
                //Возврат на экран входа
                Button {
                    presentationMode.animation().wrappedValue.dismiss()
                } label: {
                    Text("I already have an account")
                        .foregroundColor(.red)
                }
            }
            .padding(.horizontal)
            
            //Лоадер
            if viewModel.showLoadingView {
                LoadingView()
            }
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}

