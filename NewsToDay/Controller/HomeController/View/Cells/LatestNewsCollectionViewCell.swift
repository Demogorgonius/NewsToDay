//
//  LatestNewsCollectionViewCell.swift
//  NewsToDay
//
//  Created by Dmitry Medvedev on 11.05.2023.
//

import UIKit
import SnapKit

final class LatestNewsCollectionViewCell: UICollectionViewCell {
    
    private lazy var latestNewsImage: UIImageView = {
        let element = UIImageView()
        element.layer.cornerRadius = 12
        element.layer.masksToBounds = true
        return element
    }()
    
    private lazy var bookMarkButton: UIButton = {
        let element = UIButton(type: .system)
        element.tintColor = .white
        element.setBackgroundImage(UIImage(systemName: "bookmark"), for: .normal)
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
    
    func configureCell(image: String) {
        latestNewsImage.image = UIImage(named: image)
    }
    
    private func setupView() {
        addSubview(latestNewsImage)
        addSubview(bookMarkButton)
    }
    
    private func setConstraints() {
        latestNewsImage.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        bookMarkButton.snp.makeConstraints { make in
            make.height.width.equalTo(24)
            make.top.trailing.equalToSuperview().inset(24)
        }
    }
    
}
