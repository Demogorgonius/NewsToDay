//
//  AlertManager.swift
//  NewsToDay
//
//  Created by Марк Райтман on 20.05.2023.
//

import UIKit

class AlertManager {
    private static func showBasicAlert(on vc: UIViewController, title: String, message: String?) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            vc.present(alert, animated: true, completion: nil)
        }
    }
}

//MARK: - Show validation alerts
extension AlertManager {
    public static func showInvalidEmailAlert(on vc: UIViewController) {
        showBasicAlert(on: vc, title: "Invalid email", message: "Please enter a valid email")
    }
    public static func showInvalidPasswordAlert(on vc: UIViewController) {
        showBasicAlert(on: vc, title: "Invalid password", message: "Please enter a valid password")
    }
    public static func showInvalidUsernameAlert(on vc: UIViewController) {
        showBasicAlert(on: vc, title: "Invalid username", message: "Please enter a valid username")
    }
}

//MARK: - Registration errors
extension AlertManager {
    public static func showRegistrationErrorAlert(on vc: UIViewController) {
        showBasicAlert(on: vc, title: "Unknown registration error", message: nil)
    }
    public static func showRegistrationErrorAlert(on vc: UIViewController, with error: Error) {
        showBasicAlert(on: vc, title: "Registration error", message: "\(error.localizedDescription)")
    }
}

//MARK: - Log In errors
extension AlertManager {
    public static func showSignInErrorAlert(on vc: UIViewController) {
        showBasicAlert(on: vc, title: "Unknown Signing In error", message: nil)
    }
    public static func showSignInErrorAlert(on vc: UIViewController, with error: Error) {
        showBasicAlert(on: vc, title: "Signing In error", message: "\(error.localizedDescription)")
    }
}

//MARK: - Log Out errors
extension AlertManager {
    public static func showLogOutErrorAlert(on vc: UIViewController, with error: Error) {
        showBasicAlert(on: vc, title: "Log Out In error", message: "\(error.localizedDescription)")
    }
}

//MARK: - Forgot password errors
extension AlertManager {
    public static func showPasswordResetSent(on vc: UIViewController) {
        showBasicAlert(on: vc, title: "Password Reset Sent", message: nil)
    }
    public static func showErrorSendingPasswordResetAlert(on vc: UIViewController, with error: Error) {
        showBasicAlert(on: vc, title: "Sending password reset error", message: "\(error.localizedDescription)")
    }
}
    
//MARK: - Fetching user errors
extension AlertManager {
    public static func showUnknownFetchingUserError(on vc: UIViewController) {
        showBasicAlert(on: vc, title: "Unknown Error Fetching User", message: nil)
    }
    public static func showFetchingUserError(on vc: UIViewController, with error: Error) {
        showBasicAlert(on: vc, title: "Error Fetching User", message: "\(error.localizedDescription)")
    }
}
