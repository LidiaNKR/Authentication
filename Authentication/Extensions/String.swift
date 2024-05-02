//
//  String.swift
//  Authentication
//
//  Created by Лидия Некрасова on 29.04.2024.
//

import Foundation

extension String {
    
    ///Проверка текста на соотвествие формату email
    var isValidEmail: Bool {
        NSPredicate(format: "SELF MATCHES %@",
                    "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}")
        .evaluate(with: self)
    }
    
    ///Провека пароля на соотвествие формату:
    /// - Пароль должен содержать минимум 6 символов
    /// - 1 заглавную букву
    /// - 1 специальный символ
    var isValidPassword: Bool {
        NSPredicate(format: "SELF MATCHES %@",
                    "^(?=.*[a-z])(?=.*[$@$#!%*?&])(?=.*[A-Z]).{6,}$")
            .evaluate(with: self)
    }
}
