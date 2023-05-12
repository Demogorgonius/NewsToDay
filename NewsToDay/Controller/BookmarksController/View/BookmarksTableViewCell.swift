//
//  BookmarksCell.swift
//  NewsToDay
//
//  Created by Daniil Kulikovskiy on 11.05.2023.
//

import UIKit

class BookmarksTableViewCell: UITableViewCell {
    static let identifier = "BookmarksTableViewCell"
    
    private let contentWhiteView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderColor = UIColor.black.cgColor
        return view
    }()
    
    private let newsTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24, weight: .medium)
        return label
    }()
    
    private let imageNews: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .blue
        image.image = UIImage(named: "default")
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func updateNews(model: TestForBookmarks) {
        print(model)
 
            self.descriptionLabel.text = model.description
            //            self.authorLabel.text = model.author
            //            self.contentLabel.text = model.content
            self.newsTitleLabel.text = model.title
            self.imageNews.image = UIImage(named: model.image)
        
    }
    
    func layout() {
        [contentWhiteView, newsTitleLabel,descriptionLabel,imageNews].forEach { contentView.addSubview($0) }

        NSLayoutConstraint.activate([
            contentWhiteView.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentWhiteView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentWhiteView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            contentWhiteView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            imageNews.topAnchor.constraint(equalTo: contentWhiteView.topAnchor),
            imageNews.leadingAnchor.constraint(equalTo: contentWhiteView.leadingAnchor, constant: 20),
            imageNews.bottomAnchor.constraint(equalTo: contentWhiteView.bottomAnchor),
            imageNews.widthAnchor.constraint(equalToConstant: 96),

            newsTitleLabel.leadingAnchor.constraint(equalTo: imageNews.rightAnchor, constant: 16),
            newsTitleLabel.topAnchor.constraint(equalTo: contentWhiteView.topAnchor, constant: 10),
            newsTitleLabel.trailingAnchor.constraint(equalTo: contentWhiteView.trailingAnchor, constant: -19),
            newsTitleLabel.heightAnchor.constraint(equalToConstant: 70),

            descriptionLabel.topAnchor.constraint(equalTo: newsTitleLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: imageNews.rightAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentWhiteView.trailingAnchor, constant: -19),

            ])

    }
}
