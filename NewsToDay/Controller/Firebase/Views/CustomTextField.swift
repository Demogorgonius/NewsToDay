//
//  CustomTextField.swift
//  NewsToDay
//
//  Created by Марк Райтман on 20.05.2023.
//

import UIKit

class CustomTextField: UITextField {
    
    //MARK: - Enum
    enum CustomTextFieldType {
        case username
        case email
        case password
        case passwordCheck
    }
    
    //MARK: - Properties
    private let authFieldType: CustomTextFieldType
    
    //MARK: - UI components
    //Username image
    private var usernameImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(systemName: "person")
        image.tintColor = .greyPrimary
        image.frame = CGRect(x: 15, y: 15, width: 20, height: 20)
        return image
    }()
    
    //Email image
    private var emailImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(systemName: "envelope")
        image.tintColor = .greyPrimary
        image.frame = CGRect(x: 15, y: 15, width: 20, height: 20)
        return image
    }()
    
    //Password image
    private var passwordImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(systemName: "lock")
        image.tintColor = .greyPrimary
        image.frame = CGRect(x: 15, y: 15, width: 20, height: 20)
        return image
    }()
    
    //Secure text button
    private var secureTextEntryButton: UIButton = {
        let button = UIButton()
        button.configuration = .plain()
        button.tintColor = .greyPrimary
        button.setImage(UIImage(systemName: "eye"), for: .normal)
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 15), forImageIn: .normal)
        button.configuration?.imagePlacement = .trailing
        button.frame = CGRect(x: 15, y: 15, width: 20, height: 20)
        button.addTarget(self, action: #selector(secureTextEntryTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(fieldType: CustomTextFieldType) {
        authFieldType = fieldType
        super.init(frame: .zero)
        
        //Background
        backgroundColor = .secondarySystemBackground
        
        //Border
        layer.cornerRadius = 15
        
        //Text
        returnKeyType = .done
        autocorrectionType = .no
        autocapitalizationType = .none
        textColor = .greyPrimary
        
        switch fieldType {
        case .username:
            
            //text
            attributedPlaceholder = NSAttributedString(string: "Username",
                                                       attributes: [NSAttributedString.Key.foregroundColor: UIColor.greyPrimary])
            
            //left icon
            let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            leftPaddingView.addSubview(usernameImageView)
            leftView = leftPaddingView
            leftViewMode = .always
            
            //Action
            self.addTarget(self, action: #selector(textFieldEditingBegin), for: UIControl.Event.editingDidBegin)
            self.addTarget(self, action: #selector(textFieldEditingEnd), for: UIControl.Event.editingDidEnd)
            
        case .email:
            
            //text
            keyboardType = .emailAddress
            textContentType = .emailAddress
            attributedPlaceholder = NSAttributedString(string: "Email Address",
                                                       attributes: [NSAttributedString.Key.foregroundColor: UIColor.greyPrimary])
            
            //left icon
            let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            leftPaddingView.addSubview(emailImageView)
            leftView = leftPaddingView
            leftViewMode = .always
            
            //Action
            self.addTarget(self, action: #selector(textFieldEditingBegin), for: UIControl.Event.editingDidBegin)
            self.addTarget(self, action: #selector(textFieldEditingEnd), for: UIControl.Event.editingDidEnd)
            
        case .password:
            
            //text
            isSecureTextEntry = true
            attributedPlaceholder = NSAttributedString(string: "Password",
                                                       attributes: [NSAttributedString.Key.foregroundColor: UIColor.greyPrimary])
            
            //right icon
            let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            rightPaddingView.addSubview(secureTextEntryButton)
            rightView = rightPaddingView
            rightViewMode = .whileEditing
            
            //left icon
            let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            leftPaddingView.addSubview(passwordImageView)
            leftView = leftPaddingView
            leftViewMode = .always
            
            //Action
            self.addTarget(self, action: #selector(passwordTextFieldEditingBegin), for: UIControl.Event.editingDidBegin)
            self.addTarget(self, action: #selector(passwordTextFieldEditingEnd), for: UIControl.Event.editingDidEnd)
            
        case .passwordCheck:
            
            //text
            isSecureTextEntry = true
            attributedPlaceholder = NSAttributedString(string: "Repeat Password",
                                                       attributes: [NSAttributedString.Key.foregroundColor: UIColor.greyPrimary])
            
            //right icon
            let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            rightPaddingView.addSubview(secureTextEntryButton)
            rightView = rightPaddingView
            rightViewMode = .whileEditing
            
            //left icon
            let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            leftPaddingView.addSubview(passwordImageView)
            leftView = leftPaddingView
            leftViewMode = .always
            
            //Action
            self.addTarget(self, action: #selector(passwordCheckTextFieldEditingBegin), for: UIControl.Event.editingDidBegin)
            self.addTarget(self, action: #selector(passwordCheckTextFieldEditingEnd), for: UIControl.Event.editingDidEnd)
        }
    }
    
    
    //MARK: - Methods
    @objc func textFieldEditingBegin(sender: UIImage) {
        //Background
        backgroundColor = .systemBackground
        
        //Border
        layer.borderWidth = 1
        layer.borderColor = UIColor.purplePrimary.cgColor
        
        //Text + icons
        textColor = .blackDarker
        usernameImageView.tintColor = .purplePrimary
        emailImageView.tintColor = .purplePrimary
        passwordImageView.tintColor = .purplePrimary
        secureTextEntryButton.tintColor = .purplePrimary
    }
    
    @objc func textFieldEditingEnd() {
        //Background
        backgroundColor = .secondarySystemBackground
        
        //Border
        layer.borderWidth = 0
        
        //Text + icons
        textColor = .greyPrimary
        usernameImageView.tintColor = .greyPrimary
        emailImageView.tintColor = .greyPrimary
        passwordImageView.tintColor = .greyPrimary
        secureTextEntryButton.tintColor = .greyPrimary
    }
    
    @objc func passwordTextFieldEditingBegin() {
        //Background
        backgroundColor = .systemBackground
        
        //Border
        layer.borderWidth = 1
        layer.borderColor = UIColor.purplePrimary.cgColor
        
        //Text + icons
        textColor = .blackDarker
        usernameImageView.tintColor = .purplePrimary
        emailImageView.tintColor = .purplePrimary
        passwordImageView.tintColor = .purplePrimary
        secureTextEntryButton.tintColor = .purplePrimary
        secureTextEntryButton.setImage(UIImage(systemName: "eye"), for: .normal)
    }
    
    @objc func passwordTextFieldEditingEnd() {
        //Background
        backgroundColor = .secondarySystemBackground
        
        //Border
        layer.borderWidth = 0
        
        //Text + icons
        textColor = .greyPrimary
        usernameImageView.tintColor = .greyPrimary
        emailImageView.tintColor = .greyPrimary
        passwordImageView.tintColor = .greyPrimary
        isSecureTextEntry = true
    }
    
    @objc func passwordCheckTextFieldEditingBegin() {
        //Background
        backgroundColor = .systemBackground
        
        //Border
        layer.borderWidth = 1
        layer.borderColor = UIColor.purplePrimary.cgColor
        
        //Text + icons
        textColor = .blackDarker
        usernameImageView.tintColor = .purplePrimary
        emailImageView.tintColor = .purplePrimary
        passwordImageView.tintColor = .purplePrimary
        secureTextEntryButton.tintColor = .purplePrimary
        secureTextEntryButton.setImage(UIImage(systemName: "eye"), for: .normal)
    }
    
    @objc func passwordCheckTextFieldEditingEnd() {
        //Background
        backgroundColor = .secondarySystemBackground
        
        //Border
        layer.borderWidth = 0
        
        //Text + icons
        textColor = .greyPrimary
        usernameImageView.tintColor = .greyPrimary
        emailImageView.tintColor = .greyPrimary
        passwordImageView.tintColor = .greyPrimary
        isSecureTextEntry = true
    }
    
    @objc func secureTextEntryTapped() {
        isSecureTextEntry.toggle()
        if isSecureTextEntry == true {
            secureTextEntryButton.setImage(UIImage(systemName: "eye"), for: .normal)
        } else {
            secureTextEntryButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        }
    }
}
