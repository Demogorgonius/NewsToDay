//
//  CustomTextField.swift
//  NewsToDay
//
//  Created by Марк Райтман on 20.05.2023.
//

import UIKit

class CustomTextField: UITextField {
    
    enum CustomTextFieldType {
        case username
        case email
        case password
    }
    
    private let authFieldType: CustomTextFieldType
    
    init(fieldType: CustomTextFieldType) {
        authFieldType = fieldType
        super.init(frame: .zero)
        
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 15
        returnKeyType = .done
        autocorrectionType = .no
        autocapitalizationType = .none
        
        //добавить отступ слева для placeholder
        leftViewMode = .always
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
        
        switch fieldType {
        case .username:
            placeholder = "Username"
        case .email:
            placeholder = "Email address"
            keyboardType = .emailAddress
            textContentType = .emailAddress
        case .password:
            placeholder = "Password"
            isSecureTextEntry = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
