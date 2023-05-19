//
//  RecomendedNewsCollectionViewCell.swift
//  NewsToDay
//
//  Created by Dmitry Medvedev on 11.05.2023.
//

import UIKit
import SnapKit

final class RecomendedNewsCollectionViewCell: UICollectionViewCell {
    
    lazy var cellImage: UIImageView = {
        let element = UIImageView()
        element.layer.cornerRadius = 12
        element.layer.masksToBounds = true
        element.contentMode = .scaleAspectFill
        return element
    }()
    
    lazy var newsTopicLabel: UILabel = {
        let element = UILabel()
        element.font = .systemFont(ofSize: 14, weight: .light)
        element.textColor = .greyPrimary
        element.numberOfLines = 1
        return element
    }()
    
    lazy var newsLabel: UILabel = {
        let element = UILabel()
        element.font = .boldSystemFont(ofSize: 16)
        element.textColor = .blackPrimary
        element.numberOfLines = 2
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
    
    func configureCell(image: URL?, newTopic: String, news: String) {
        cellImage.kf.setImage(with: image)
        newsTopicLabel.text = newTopic
        newsLabel.text = news
    }
    
    private func setupView() {
        addSubview(cellImage)
        addSubview(newsTopicLabel)
        addSubview(newsLabel)
    }
    
    private func setConstraints() {
        cellImage.snp.makeConstraints { make in
            make.height.width.equalTo(96)
            make.leading.equalToSuperview()
        }
        
        newsTopicLabel.snp.makeConstraints { make in
            make.leading.equalTo(cellImage.snp.trailing).offset(16)
            make.trailing.equalToSuperview()
            make.top.equalTo(cellImage.snp.top).offset(7)
            make.height.equalTo(20)
        }
        
        newsLabel.snp.makeConstraints { make in
            make.leading.equalTo(cellImage.snp.trailing).offset(16)
            make.top.equalTo(newsTopicLabel.snp.bottom).offset(8)
            make.trailing.equalToSuperview()
        }
    }
}
