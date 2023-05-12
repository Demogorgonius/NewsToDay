//
//  TextFieldCollectionViewCell.swift
//  NewsToDay
//
//  Created by Dmitry Medvedev on 11.05.2023.
//

import UIKit
import SnapKit

final class TextFieldCollectionViewCell: UICollectionViewCell {
    private lazy var descriptionNewsLabel: UILabel = {
        let element = UILabel()
        element.text = "Discover things of this world"
        element.font = .systemFont(ofSize: 16)
        element.textColor = UIColor(hexString: "#7C82A1")
        return element
    }()
    
    private lazy var searchTextField: UITextField = {
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
        addSubview(descriptionNewsLabel)
        addSubview(searchTextField)
    }
    
    func setConstraints() {
        descriptionNewsLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(24)
        }
        
        searchTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(descriptionNewsLabel.snp.bottom).offset(32)
            make.height.equalTo(56)
        }
    }
    
}
