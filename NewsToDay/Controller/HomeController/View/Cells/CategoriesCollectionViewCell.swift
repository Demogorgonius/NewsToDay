//
//  CategoriesCollectionViewCell.swift
//  NewsToDay
//
//  Created by Dmitry Medvedev on 11.05.2023.
//

import UIKit
import SnapKit

final class CategoriesCollectionViewCell: UICollectionViewCell {
    
    private lazy var categoryLabel: UILabel = {
        let element = UILabel()
        element.layer.cornerRadius = 16
        element.layer.masksToBounds = true
        element.numberOfLines = 1
        element.textAlignment = .center
        element.backgroundColor = UIColor(hexString: "#F3F4F6")
        element.font = .systemFont(ofSize: 12)
        element.textColor = UIColor(hexString: "#7C82A1")
        element.tintColor = UIColor(hexString: "#475AD7")
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
    
    func configureCell(topicName: String) {
        categoryLabel.text = topicName
    }
    
    func setupView() {
        addSubview(categoryLabel)
    }
    
    func setConstraints() {
        categoryLabel.snp.makeConstraints { make in
            make.height.equalTo(32)
            make.width.equalTo(80)
        }
    }
}
