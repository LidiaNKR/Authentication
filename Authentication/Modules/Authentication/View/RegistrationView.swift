//
//  RegistrationView.swift
//  Authentication
//
//  Created by Лидия Некрасова on 29.04.2024.
//

import SwiftUI

struct RegistrationView: View {
    
    // MARK: - Navigation
    
    @Environment(\.presentationMode) var presentationMode
    
    // MARK: - Properties
    
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    @State var username: String = ""
    @State var password: String = ""
    @State var passwordAgain: String = ""
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            VStack() {
                
                Spacer()
                
                //Заголовок
                Text(L10n.registrationTitle)
                    .mainTitleStyle()
                
                //Поле ввода эл. почты
                EmailTextField(title: L10n.enterEmailTitle,
                               text: $username)
                
                //Поле ввода пароля
                PasswordSecureField(title: L10n.enterPasswordTitle,
                                    text: $password,
                                    isValidPassword: Binding(
                                        get: { self.password.isValidPassword },
                                        set: {_ in }
                                    ),
                                    ifNeedCheckValidation: true)
                
                //Поле подтверждения пароля
                PasswordSecureField(title: L10n.repeatPasswordTitle,
                                    text: $passwordAgain,
                                    isValidPassword: Binding(
                                        get: { self.password == self.passwordAgain },
                                        set: {_ in }
                                    ),
                                    ifNeedCheckValidation: true)
                
                //Регистрация
                MainButton(title: L10n.registrationButtonTitle) {
                    viewModel.showLoadingView.toggle()

                    Task {
                        try await viewModel.signUp(withEmail: username, password: password)
                    }
                }
                .padding(.top)
                
                //Алерт
                .alert(isPresented: $viewModel.showAlert) {
                    Alert(title: Text(viewModel.isDismissView ? L10n.alertSuccessRegistrationTitle : L10n.alertTitle),
                          message: Text(viewModel.message),
                          dismissButton: .default(Text(L10n.alertButtonTitle)) {
                        if viewModel.isDismissView { presentationMode.animation().wrappedValue.dismiss()
                        }
                        viewModel.showLoadingView.toggle()
                    })
                }
                
                Spacer()
                
                //Возврат на экран входа
                Button {
                    presentationMode.animation().wrappedValue.dismiss()
                } label: {
                    Text(L10n.hasRegistrationButtonTitle)
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

