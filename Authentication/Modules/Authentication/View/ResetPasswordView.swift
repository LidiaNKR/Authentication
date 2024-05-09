//
//  ResetPasswordView.swift
//  Authentication
//
//  Created by Лидия Некрасова on 29.04.2024.
//

import SwiftUI

struct ResetPasswordView: View {
    
    // MARK: - Navigation
    
    @Environment(\.presentationMode) private var presentationMode
    
    // MARK: - Properties
    
    @EnvironmentObject private var viewModel: AuthenticationViewModel
    
    @State private var email: String = ""
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            VStack {
                
                //Заголовок
                Text("Password recovery")
                    .mainTitleStyle()
                
                //Поле ввода эл. почты
                EmailTextField(title: "Enter your E-mail",
                                text: $email)
                
                //Сбросить пароль
                MainButton(title: "Reset password") {
                    
                    viewModel.showLoadingView.toggle()
                    
                    Task {
                        try await viewModel.resetPassword(email: email)
                    }
                }
                .padding(.top)
                
                //Алерт
                .alert(isPresented: $viewModel.showAlert) {
                    
                    Alert(title:
                            Text(viewModel.isDismissView 
                                 ? "Password reset successful"
                                 : "Error"),
                          dismissButton: .default(Text("Ok")) {
                        if viewModel.isDismissView {
                            presentationMode.animation().wrappedValue.dismiss()
                        }
                        viewModel.showLoadingView.toggle()
                    })
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

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
    }
}

