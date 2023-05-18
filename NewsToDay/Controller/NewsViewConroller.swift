//
//  NewsViewConroller.swift
//  NewsToDay
//
//  Created by Daniil Kulikovskiy on 09.05.2023.
//

import UIKit

class NewsViewConroller: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        newsManager.delegate = self
//        newsManager.getNews(for: "sports")
        view.backgroundColor = .white
        layout()
    }
    
    lazy var pictureNews: UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .blue
        image.image = UIImage(named: "default")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scroolView = UIScrollView()
        scroolView.showsVerticalScrollIndicator = true
        scroolView.alwaysBounceVertical = true
        scroolView.translatesAutoresizingMaskIntoConstraints = false
        return scroolView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    lazy var titleLabel: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.numberOfLines = 0
        text.font = UIFont(name: Fonts.interBold, size: 24)
        text.textColor = UIColor(named: Colors.white)
//        text.setLineHeight(30)
        text.text = "The latest situation in the presidential election"
        text.textAlignment = .left
        return text
    }()
    
    lazy var autorName: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.numberOfLines = 0
        text.font = UIFont(name: Fonts.interRegular, size: 24)
        text.textColor = UIColor(named: Colors.white)
        text.setLineHeight(24)
        text.text = "John Doe"
        return text
    }()
    
    private lazy var autor: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.numberOfLines = 0
        text.font = UIFont(name: Fonts.interRegular, size: 18)
        text.textColor = UIColor(named: Colors.greyLight)
//        text.setLineHeight(20)
        text.text = "Author"
        return text
    }()
    
    lazy var category: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.numberOfLines = 0
        text.font = UIFont(name: Fonts.interRegular, size: 14)
        text.textColor = UIColor(named: Colors.greyLight)
//        text.setLineHeight(20)
        text.text = "Politics"
        text.textColor = .white
        text.textAlignment = .center
        text.backgroundColor = UIColor(named: Colors.purplePrimary)
        text.layer.cornerRadius = 16
        text.layer.masksToBounds = true
        return text
    }()
    
    lazy var textDiscription: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.numberOfLines = 0
        text.font = UIFont(name: Fonts.interRegular, size: 20)
        text.textColor = UIColor(named: Colors.greyDarker)
        text.setLineHeight(24)
        text.text = "Leads in individual states may change from one party to another as all the votes are counted. Select a state for detailed results, and select the Senate, House or Governor tabs to view those races. For more detailed state results click on the States A-Z links at the bottom of this page. Results source: NEP/Edison via Reuters. Leads in individual states may change from one party to another as all the votes are counted. Select a state for detailed results, and select the Senate, House or Governor tabs to view those races. For more detailed state results click on the States A-Z links at the bottom of this page. Results source: NEP/Edison via Reuters."
        return text
    }()
}

extension NewsViewConroller {
    func layout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(pictureNews)
        contentView.addSubview(category)
        contentView.addSubview(titleLabel)
        contentView.addSubview(autorName)
        contentView.addSubview(autor)
        contentView.addSubview(textDiscription)
        
        
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            pictureNews.topAnchor.constraint(equalTo: contentView.topAnchor),
            pictureNews.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            pictureNews.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            pictureNews.heightAnchor.constraint(equalToConstant: 384),
            
            category.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -16),
            category.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            category.widthAnchor.constraint(equalToConstant: 75),
            category.heightAnchor.constraint(equalToConstant: 35),
            
            titleLabel.bottomAnchor.constraint(equalTo: autorName.topAnchor, constant: -24),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            titleLabel.heightAnchor.constraint(equalToConstant: 60),
            
            autorName.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            autorName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 26),
//            autorName.bottomAnchor.constraint(equalTo: pictureNews.bottomAnchor, constant: -48),
            
            autor.topAnchor.constraint(equalTo: autorName.bottomAnchor),
            autor.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 26),
            autor.bottomAnchor.constraint(equalTo: pictureNews.bottomAnchor, constant: -24),
            
            textDiscription.topAnchor.constraint(equalTo: pictureNews.bottomAnchor, constant: 44),
            textDiscription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            textDiscription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            textDiscription.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -15)
        ])

    }

}
