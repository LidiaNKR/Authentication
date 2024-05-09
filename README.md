# ImageEditor

Приложение для редактирования изображений с аутентификацией.
Поддержка темной/светлой темы.

# Интерфейс
1. Экран входа в аккаунт, с валидацией введенного email и проверкой подтверждения эл. почты.
Возможность аутентификации через эл. почту/Google аккаунт

<p align="center" width="100%">
    <img width="30%" src="https://github.com/LidiaNKR/ImageEditor/blob/20b41ff3c70c9dc6b1c983b52d806a5b4155473a/Images/login.PNG">
</p>

2. Экран регистрации/Сброса пароля.
При регистрации через эл. почту отправляется письмо для ее подтверждения.

<p align="center" width="100%">
    <img width="30%" src="https://github.com/LidiaNKR/ImageEditor/blob/20b41ff3c70c9dc6b1c983b52d806a5b4155473a/Images/registration.PNG">
    <img width="30%" src="https://github.com/LidiaNKR/ImageEditor/blob/fd5d274e1ae3729ffcb88a67c548d2fd5550bff4/Images/resetPassword.PNG">
</p>

3. Экран выбора изображения для редактирование и непосредственно редактирование изображения с помощь:
- инструменов для рисования, 
- применения фильтров, 
- добавления текста.
Также реализована возможность сохранения и отправки изображения через соц. сети и пр.

<p align="center" width="100%">
    <img width="25%" src="https://github.com/LidiaNKR/ImageEditor/blob/20b41ff3c70c9dc6b1c983b52d806a5b4155473a/Images/chooseImage.PNG">
    <img width="25%" src="https://github.com/LidiaNKR/ImageEditor/blob/20b41ff3c70c9dc6b1c983b52d806a5b4155473a/Images/editor.PNG">
    <img width="25%" src="https://github.com/LidiaNKR/ImageEditor/blob/20b41ff3c70c9dc6b1c983b52d806a5b4155473a/Images/addText.PNG">
    <img width="25%" src="https://github.com/LidiaNKR/ImageEditor/blob/20b41ff3c70c9dc6b1c983b52d806a5b4155473a/Images/filter.PNG">
</p>

# Используемый стек технологий
- Язык программирования - `Swift`
- Интерфейс - `SwiftUI`
- Архитектура - `MVVM`
- Frameworks: `Firebase Auth`, `Google SignIn`, `CoreImage`, `PencilKit`, `Photos`, `SwiftGen`/`String Catalogs`
- iOS 16.0+

