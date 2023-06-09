//
//  BookmarksCell.swift
//  NewsToDay
//
//  Created by Daniil Kulikovskiy on 11.05.2023.
//

import UIKit

class BookmarksTableViewCell: UITableViewCell {
    static let identifier = "BookmarksTableViewCell"
    
    private let newsTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: Fonts.interLight, size: 14)
        label.textColor = UIColor(named: Resources.Colors.greyPrimary)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: Fonts.interRegular, size: 16)
        label.numberOfLines = 2
        return label
    }()
    
    private let imageNews: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .blue
        image.image = UIImage(named: "default")
        image.layer.cornerRadius = 12
        image.layer.masksToBounds = true
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
 
            self.descriptionLabel.text = "A Simple Trick For Creating Color Palettes Quickly"

            //            self.authorLabel.text = model.author
            //            self.contentLabel.text = model.content
            self.newsTitleLabel.text = model.title
            self.imageNews.image = UIImage(named: model.image)
        
    }
    
    
    
    func layout() {
        [newsTitleLabel,descriptionLabel,imageNews].forEach { contentView.addSubview($0) }

        NSLayoutConstraint.activate([
            
            imageNews.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            imageNews.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            imageNews.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            imageNews.widthAnchor.constraint(equalToConstant: 96),
            imageNews.heightAnchor.constraint(equalToConstant: 96),

            newsTitleLabel.leadingAnchor.constraint(equalTo: imageNews.trailingAnchor, constant: 16),
            newsTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            newsTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -19),

            descriptionLabel.topAnchor.constraint(equalTo: newsTitleLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: imageNews.trailingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -19),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 50)
    
            ])

    }
}
