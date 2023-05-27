//
//  LoginController.swift
//  NewsToDay
//
//  Created by Марк Райтман on 20.05.2023.
//

import UIKit

class LoginController: UIViewController {
    
    //MARK: - UI Components
    private let headerView = AuthHeaderView(title: "Welcome Back 👋", subtitle: "I am happy to see you again. You can continue where you left off by logging in")
    
    private let emailField = CustomTextField(fieldType: .email)
    private let passwordField = CustomTextField(fieldType: .password)
    
    private let signInButton = CustomButton(title: "Sign In", hasBackground: true, fontSize: .med)
    private let newUserButton = CustomButton(title: "Don't have an account? Sign Up", hasBackground: false, fontSize: .med)
    private let forgotPasswordButton = CustomButton(title: "Forgot password?", hasBackground: false, fontSize: .small)
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        buttonsTapped()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    //MARK: - Methods
    private func buttonsTapped() {
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        newUserButton.addTarget(self, action: #selector(didTapNewUser), for: .touchUpInside)
        forgotPasswordButton.addTarget(self, action: #selector(didTapForgotPassword), for: .touchUpInside)
    }
    
    @objc private func didTapSignIn() {
        let loginRequest = LoginUserRequest(
            email: self.emailField.text ?? "",
            password: self.passwordField.text ?? ""
        )
        
        // Email check
        if !Validator.isValidEmail(for: loginRequest.email) {
            AlertManager.showInvalidEmailAlert(on: self)
            return
        }
        
        // Password check
        if !Validator.isPasswordValid(for: loginRequest.password) {
            AlertManager.showInvalidPasswordAlert(on: self)
            return
        }
        
        AuthService.shared.signIn(with: loginRequest) { error in
            if let error = error {
                AlertManager.showSignInErrorAlert(on: self, with: error)
                return
            }
            
            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                sceneDelegate.checkAuthentication()
            } else {
                AlertManager.showSignInErrorAlert(on: self)
            }
        }
    }
    @objc private func didTapNewUser() {
        let vc = RegisterController()
    
        present(vc, animated: true)
    }
    @objc private func didTapForgotPassword() {
        let vc = ForgotPasswordController()
        present(vc, animated: true)
    }
    
    //MARK: - UI Setup
    func setupUI() {
        view.backgroundColor = .systemBackground
        
        /// ADDING SUBVIEWS
        view?.addSubview(headerView)
        view?.addSubview(emailField)
        view?.addSubview(passwordField)
        view?.addSubview(signInButton)
        view?.addSubview(newUserButton)
        view?.addSubview(forgotPasswordButton)
        
        /// TAMIC
        headerView.translatesAutoresizingMaskIntoConstraints = false
        emailField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        newUserButton.translatesAutoresizingMaskIntoConstraints = false
        forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        
        /// SETUP CONSTRAINTS
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 280),
            
            emailField.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 45),
            emailField.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            emailField.heightAnchor.constraint(equalToConstant: 55),
            emailField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 15),
            passwordField.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            passwordField.heightAnchor.constraint(equalToConstant: 55),
            passwordField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            signInButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 45),
            signInButton.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            signInButton.heightAnchor.constraint(equalToConstant: 55),
            signInButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            newUserButton.bottomAnchor.constraint(equalTo: forgotPasswordButton.topAnchor, constant: -5),
            newUserButton.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            newUserButton.heightAnchor.constraint(equalToConstant: 22),
            newUserButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            forgotPasswordButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            forgotPasswordButton.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            forgotPasswordButton.heightAnchor.constraint(equalToConstant: 22),
            forgotPasswordButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
        ])
        
    }


}
