//
//  CustomButton.swift
//  NewsToDay
//
//  Created by Марк Райтман on 20.05.2023.
//

import UIKit

class CustomButton: UIButton {
    
    enum FontSize {
        case big
        case med
        case small
    }
    
    init(title: String, hasBackground: Bool = false, fontSize: FontSize) {
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        layer.cornerRadius = 15
        layer.masksToBounds = true
        
        backgroundColor = hasBackground ? .systemBlue : .clear
        
        let titleColor: UIColor = hasBackground ? .white : .systemBlue
        setTitleColor(titleColor, for: .normal)
        
        switch fontSize {
        case .big:
            titleLabel?.font = .systemFont(ofSize: 22, weight: .bold)
        case .med:
            titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        case .small:
            titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

