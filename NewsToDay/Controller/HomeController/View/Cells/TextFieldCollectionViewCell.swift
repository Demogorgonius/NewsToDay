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
        element.text = NSLocalizedString("descriptionHomeVC", comment: "")
        element.font = .systemFont(ofSize: 16)
        element.textColor = .greyPrimary
        return element
    }()
    
    private lazy var mainView: UIView = {
        let element = UIView()
        element.backgroundColor = .greyLighter
        element.layer.cornerRadius = 12
        element.layer.masksToBounds = true
        return element
    }()
    
    private lazy var searchButton: UIButton = {
        let element = UIButton(type: .system)
        element.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        element.tintColor = .greyPrimary
        return element
    }()
    
    private lazy var searchTextField: UITextField = {
        let element = UITextField()
        element.placeholder = NSLocalizedString("textFieldPlaceholder", comment: "")
        element.backgroundColor = .clear
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
        addSubview(mainView)
        mainView.addSubview(searchButton)
        mainView.addSubview(searchTextField)
    }
    
    func setConstraints() {
        mainView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(descriptionNewsLabel.snp.bottom).offset(25)
            make.height.equalTo(56)
        }
        
        descriptionNewsLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(24)
        }
        
        searchButton.snp.makeConstraints { make in
            make.height.leading.equalToSuperview()
            make.width.equalTo(50)
        }
        
        searchTextField.snp.makeConstraints { make in
            make.height.trailing.equalToSuperview()
            make.leading.equalTo(searchButton.snp.trailing)
//            make.leading.trailing.equalToSuperview()
//            make.top.equalTo(descriptionNewsLabel.snp.bottom).offset(32)
//            make.height.equalTo(56)
        }
    }
    
}
