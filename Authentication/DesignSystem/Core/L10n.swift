// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum L10n {
  /// Ok
  public static let alertButtonTitle = L10n.tr("Localizable", "alertButtonTitle", fallback: "Ok")
  /// Email not verified
  public static let alertEmailNotConfirmed = L10n.tr("Localizable", "alertEmailNotConfirmed", fallback: "Email not verified")
  /// A confirmation message has been sent to your email
  public static let alertSendEmailConfirmed = L10n.tr("Localizable", "alertSendEmailConfirmed", fallback: "A confirmation message has been sent to your email")
  /// A message has been sent to your email to set a new password
  public static let alertSendPasswordReset = L10n.tr("Localizable", "alertSendPasswordReset", fallback: "A message has been sent to your email to set a new password")
  /// Registration completed successfully
  public static let alertSuccessRegistrationTitle = L10n.tr("Localizable", "alertSuccessRegistrationTitle", fallback: "Registration completed successfully")
  /// Password reset successful
  public static let alertSuccessResetPasswordTitle = L10n.tr("Localizable", "alertSuccessResetPasswordTitle", fallback: "Password reset successful")
  /// Image saved successfully
  public static let alertSuccessSaveImage = L10n.tr("Localizable", "alertSuccessSaveImage", fallback: "Image saved successfully")
  /// Done
  public static let alertSuccessTitle = L10n.tr("Localizable", "alertSuccessTitle", fallback: "Done")
  /// Error
  public static let alertTitle = L10n.tr("Localizable", "alertTitle", fallback: "Error")
  /// Сamera
  public static let camera = L10n.tr("Localizable", "camera", fallback: "Сamera")
  /// Choose your picture
  public static let chooseYourPicture = L10n.tr("Localizable", "chooseYourPicture", fallback: "Choose your picture")
  /// Enter your E-mail
  public static let enterEmailTitle = L10n.tr("Localizable", "enterEmailTitle", fallback: "Enter your E-mail")
  /// Enter your password
  public static let enterPasswordTitle = L10n.tr("Localizable", "enterPasswordTitle", fallback: "Enter your password")
  /// Forgot your password?
  public static let forgotPassword = L10n.tr("Localizable", "forgotPassword", fallback: "Forgot your password?")
  /// Sign in with Google
  public static let googleButtonTitle = L10n.tr("Localizable", "googleButtonTitle", fallback: "Sign in with Google")
  /// I already have an account
  public static let hasRegistrationButtonTitle = L10n.tr("Localizable", "hasRegistrationButtonTitle", fallback: "I already have an account")
  /// Login
  public static let loginButtonTitle = L10n.tr("Localizable", "loginButtonTitle", fallback: "Login")
  /// Please login to continue
  public static let loginText = L10n.tr("Localizable", "loginText", fallback: "Please login to continue")
  /// Login to your personal account
  public static let loginTitle = L10n.tr("Localizable", "loginTitle", fallback: "Login to your personal account")
  /// Or
  public static let or = L10n.tr("Localizable", "or", fallback: "Or")
  /// Gallery
  public static let photoLibrary = L10n.tr("Localizable", "photoLibrary", fallback: "Gallery")
  /// Register
  public static let registrationButtonTitle = L10n.tr("Localizable", "registrationButtonTitle", fallback: "Register")
  /// Registration
  public static let registrationTitle = L10n.tr("Localizable", "registrationTitle", fallback: "Registration")
  /// Confirm password
  public static let repeatPasswordTitle = L10n.tr("Localizable", "repeatPasswordTitle", fallback: "Confirm password")
  /// Password recovery
  public static let resetPassword = L10n.tr("Localizable", "resetPassword", fallback: "Password recovery")
  /// Reset password
  public static let resetPasswordButtonTitle = L10n.tr("Localizable", "resetPasswordButtonTitle", fallback: "Reset password")
  /// Select an image
  public static let selectPhoto = L10n.tr("Localizable", "selectPhoto", fallback: "Select an image")
  /// Sign up
  public static let signUp = L10n.tr("Localizable", "signUp", fallback: "Sign up")
  /// Type here
  public static let typeHere = L10n.tr("Localizable", "typeHere", fallback: "Type here")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
