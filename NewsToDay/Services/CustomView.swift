//
//  CustomView.swift
//  NewsToDay
//
//  Created by Sergey on 09.05.2023.
//

import UIKit

class CustomView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setViews()
        layoutViews()
    }
    
    func setViews() {
        backgroundColor = UIColor.systemBackground
    }
    
    func layoutViews() {
        
    }
}
