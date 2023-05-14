//
//  LatestNewsCollectionViewCell.swift
//  NewsToDay
//
//  Created by Dmitry Medvedev on 11.05.2023.
//

import UIKit
import SnapKit

final class LatestNewsCollectionViewCell: UICollectionViewCell {
    
    var bookMarkChangeColor: Bool = false
    
    private lazy var latestNewsImage: UIImageView = {
        let element = UIImageView()
        element.layer.cornerRadius = 12
        element.layer.masksToBounds = true
        element.contentMode = .scaleAspectFill
        return element
    }()
    
    private lazy var topicNewsLabel: UILabel = {
        let element = UILabel()
        element.textColor = .greyLighter
        element.font = .systemFont(ofSize: 12)
        element.textAlignment = .left
        element.backgroundColor = .clear
        return element
    }()
    
    private lazy var newsLabel: UILabel = {
        let element = UILabel()
        element.textColor = .white
        element.font = .boldSystemFont(ofSize: 16)
        element.numberOfLines = 0
        element.textAlignment = .left
        element.backgroundColor = .clear
        return element
    }()
    
    private lazy var bookMarkButton: UIButton = {
        let element = UIButton()
        element.tintColor = .white
        element.setBackgroundImage(UIImage(systemName: "bookmark"), for: .normal)
        element.addTarget(self, action: #selector(yellow), for: .touchUpInside)
        return element
    }()
    
    @objc private func yellow() {
        if bookMarkChangeColor == false {
            bookMarkButton.setBackgroundImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            bookMarkButton.tintColor = .systemYellow
            bookMarkChangeColor = true
        } else {
            bookMarkButton.setBackgroundImage(UIImage(systemName: "bookmark"), for: .normal)
            bookMarkButton.tintColor = .white
            bookMarkChangeColor = false
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(image: String, topic: String, news: String) {
        latestNewsImage.image = UIImage(named: image)
        topicNewsLabel.text = topic
        newsLabel.text = news
    }
    
    private func setupView() {
        addSubview(latestNewsImage)
        addSubview(bookMarkButton)
        addSubview(topicNewsLabel)
        addSubview(newsLabel)
    }
    
    private func setConstraints() {
        latestNewsImage.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        bookMarkButton.snp.makeConstraints { make in
            make.height.width.equalTo(24)
            make.top.trailing.equalToSuperview().inset(24)
        }
        
        newsLabel.snp.makeConstraints { make in
            make.width.equalTo(208)
            make.height.equalTo(48)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-24)
        }
        
        topicNewsLabel.snp.makeConstraints { make in
            make.height.equalTo(16)
            make.width.equalTo(100)
            make.leading.equalToSuperview().offset(24)
            make.bottom.equalTo(newsLabel.snp.top).offset(-8)
        }
    }
    
}