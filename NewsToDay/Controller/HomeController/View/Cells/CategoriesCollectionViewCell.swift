//
//  CategoriesCollectionViewCell.swift
//  NewsToDay
//
//  Created by Dmitry Medvedev on 11.05.2023.
//

import UIKit
import SnapKit

final class CategoriesCollectionViewCell: UICollectionViewCell {
    
    lazy var categoryLabel: UILabel = {
        let element = UILabel()
        element.layer.cornerRadius = 16
        element.layer.masksToBounds = true
        element.numberOfLines = 1
        element.textAlignment = .center
        element.backgroundColor = .greyLighter
        element.font = UIFont(name: Fonts.interRegular, size: 12)
        element.textColor = .greyPrimary
        return element
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setConstraints()
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                categoryLabel.backgroundColor = .purplePrimary
                categoryLabel.textColor = .white
            }
            else {
                categoryLabel.backgroundColor = .greyLighter
                categoryLabel.textColor = .greyPrimary
            }
        }
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
