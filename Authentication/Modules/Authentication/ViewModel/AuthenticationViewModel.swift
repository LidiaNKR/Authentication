//
//  AuthenticationViewModel.swift
//  Authentication
//
//  Created by Лидия Некрасова on 29.04.2024.
//

import Firebase
import GoogleSignIn

@MainActor
final class AuthenticationViewModel: ObservableObject {
    
    // MARK: - SignInState
    
    enum SignInState {
        case signedIn
        case signedOut
    }
    
    // MARK: - Properties
    
    @Published var state: SignInState = .signedOut
    @Published var showLoadingView: Bool = false
    @Published var message: String = ""
    @Published var showAlert: Bool = false
    @Published var isDismissView: Bool = false
    
    private var authUser : User? {
        return Auth.auth().currentUser
    }
    
    // MARK: - Initializers
    
    init() {
        state = (authUser != nil && authUser?.isEmailVerified  ?? false) ? .signedIn : .signedOut
    }
    
    // MARK: - UI
    
    func showAlert(messageTitle: String, isDismiss: Bool = false) {
        message = messageTitle
        showAlert.toggle()
        isDismissView = isDismiss
    }
    
    // MARK: - SignInWithGoogle
    
    func signIn(withEmail email: String, password: String)  async throws {
        
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            
            if !result.user.isEmailVerified {
                ///Выводим ошибку о том, что email не подтвержден
                showAlert(messageTitle: L10n.alertEmailNotConfirmed)
            } else {
                ///Осуществляем вход в учетную запись
                showLoadingView.toggle()
                state = .signedIn
            }
        } catch {
            showAlert(messageTitle: error.localizedDescription)
        }
    }
    
    // MARK: - Authentication
    
    /// Регистрация учетной записи с помощью эл. почты
    /// - Parameters:
    ///   - email: эл. почта
    ///   - password: пароль
    func signUp(withEmail email: String,
                password: String) async throws {
        
        do {
            try await Auth.auth().createUser(withEmail: email, password: password)
            
            ///Отправляем подтверждение на эл. почту
            sendVerificatiOnMail()
            
            ///Выводим алерт об успешной регистрации
            showAlert(
                messageTitle: L10n.alertSendEmailConfirmed,
                isDismiss: true)
            
        } catch {
            showAlert(messageTitle: error.localizedDescription)
        }
    }
    
    /// Авторизация с помощью эл. почты
    /// - Parameter email: эл. почта
    func resetPassword(email: String) async throws {
        
        do {
            try await Auth.auth().sendPasswordReset(withEmail: email)
            
            ///Выводим алерт об успешноом сбросе пароля
            showAlert(
                messageTitle: L10n.alertSendPasswordReset,
                isDismiss: true)

        } catch {
            showAlert(messageTitle: error.localizedDescription)
        }
    }
    
    /// Авторизация с помощью Google аккаунта
    func signInWithGoogle() {
        /// Получаем id клиента
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        /// Создаем объект конфигурации входа в Google с id клиента
        let configuration = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = configuration
        
        guard let rootViewController = UIWindow.getRootViewController else { return }
        
        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { [weak self] signInResult, error in
            guard let self, let signInResult else { return }
            
            if let error = error {
                showAlert(messageTitle: error.localizedDescription)
                return
            }
            
            authenticateUser(for: signInResult.user)
        }
    }
    
    /// Выход из учетной записи
    func signOut(completion: @escaping (Error?) -> Void) {
        
        do {
            ///Выход из учетной записи
            try Auth.auth().signOut()
            
            ///Меняем статус авторизации
            state = .signedOut
            
            completion(nil)
        } catch {
            completion(error)
        }
    }
    
    /// Авторизация через учетную запись Google
    private func authenticateUser(for user: GIDGoogleUser) {
        guard let idToken = user.idToken else { return }
        
        let accessToken = user.accessToken
        let credentail = GoogleAuthProvider.credential(
            withIDToken: idToken.tokenString,
            accessToken: accessToken.tokenString
        )
        
        Auth.auth().signIn(with: credentail) { [weak self] (_, error) in
            guard let self else { return }

            if let error = error {
                showAlert(messageTitle: error.localizedDescription)
            } else {
                ///Меняем статус авторизации
                state = .signedIn
            }
        }
    }
    
    /// Отправка письма на эл. почту для ее подтверждения
    private func sendVerificatiOnMail() {
        guard let authUser else { return }
        
        ///Отправляем письмо для подтверждения эл. почты.
        authUser.sendEmailVerification() { [weak self] error in
            guard let self else { return }
            
            if let error {
                showAlert(messageTitle: error.localizedDescription)
            }
        }
    }
}
