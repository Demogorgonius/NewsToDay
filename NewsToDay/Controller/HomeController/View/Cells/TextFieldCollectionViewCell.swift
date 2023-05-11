//
//  TextFieldCollectionViewCell.swift
//  NewsToDay
//
//  Created by Dmitry Medvedev on 11.05.2023.
//

import UIKit
import SnapKit

final class TextFieldCollectionViewCell: UICollectionViewCell {
    lazy var searchTextField: UITextField = {
        let element = UITextField()
        element.borderStyle = .roundedRect
        element.placeholder = "Search"
        element.backgroundColor = .tertiarySystemFill
        element.textAlignment = .left
        element.font = .systemFont(ofSize: 16)
        element.autocapitalizationType = .words
        element.returnKeyType = .search
        return element
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(searchTextField)
    }
    
    func setConstraints() {
        searchTextField.snp.makeConstraints { make in
//            make.leading.trailing.equalToSuperview().inset(20)
//            make.bottom.equalTo(descriptionNewsLabel.snp.bottom).offset(32)
//            make.height.equalTo(56)
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
}
