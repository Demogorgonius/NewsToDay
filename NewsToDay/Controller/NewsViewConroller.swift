//
//  NewsViewConroller.swift
//  NewsToDay
//
//  Created by Daniil Kulikovskiy on 09.05.2023.
//

import UIKit

final class NewsViewConroller: UIViewController {
    
    var bookMarkChangeColor: Bool = false
    var linkNews: String?
    var news: Results?
    let bookmarksManager = BookMarksManager()
    
    lazy var pictureNews: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .blue
        image.image = UIImage(named: "default")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
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
        text.font = UIFont(name: Fonts.semiBold, size: 18)
        text.textColor = UIColor(named: Colors.white)
        text.setLineHeight(24)
        text.text = "John Doe"
        return text
    }()
    
    private lazy var autor: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.numberOfLines = 0
        text.font = UIFont(name: Fonts.interRegular, size: 16)
        text.textColor = UIColor(named: Colors.greyLight)
        //        text.setLineHeight(20)
        text.text = "Author"
        return text
    }()
    
    private lazy var bookMarkButton: UIButton = {
        let button = UIButton()
        let iconConfiguration = UIImage.SymbolConfiguration(pointSize: 25, weight: .medium, scale: .medium)
        let image = UIImage(systemName: "bookmark", withConfiguration: iconConfiguration)
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(addToBookmarks), for: .touchUpInside)
        button.layer.cornerRadius = 16
        return button
    }()
    
    private lazy var shareButton: UIButton = {
        let button = UIButton(type: .system)
        let iconConfiguration = UIImage.SymbolConfiguration(pointSize: 25, weight: .medium, scale: .medium)
        let image = UIImage(systemName: "arrowshape.turn.up.right", withConfiguration: iconConfiguration)
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(sharedAction), for: .touchUpInside)
        button.layer.cornerRadius = 16
        return button
    }()
    
//    private lazy var backButton: UIButton = {
//        let button = UIButton()
//        button.tintColor = .white
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setBackgroundImage(UIImage(systemName: "arrow.backward"), for: .normal)
//        button.addTarget(self, action: #selector(goBackAction), for: .touchUpInside)
//        return button
//    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        let iconConfiguration = UIImage.SymbolConfiguration(pointSize: 25, weight: .medium, scale: .medium)
        let image = UIImage(systemName: "arrow.left", withConfiguration: iconConfiguration)
        button.setImage(image, for: .normal)
        button.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 16
        return button
    }()
    
    
    lazy var category: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.numberOfLines = 0
        text.font = UIFont(name: Fonts.semiBold, size: 14)
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
        text.font = UIFont(name: Fonts.interRegular, size: 19)
        text.textColor = UIColor(named: Colors.greyDarker)
        text.setLineHeight(24)
        text.text = "Leads in individual states may change from one party to another as all the votes are counted. Select a state for detailed results, and select the Senate, House or Governor tabs to view those races. For more detailed state results click on the States A-Z links at the bottom of this page. Results source: NEP/Edison via Reuters. Leads in individual states may change from one party to another as all the votes are counted. Select a state for detailed results, and select the Senate, House or Governor tabs to view those races. For more detailed state results click on the States A-Z links at the bottom of this page. Results source: NEP/Edison via Reuters."
        return text
    }()
    
    init(with news: Results) {
        
        self.news = news
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureView()
        layout()
        navigationController?.isNavigationBarHidden = true

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    private func configureView() {
        guard let news = news else { return }
        
        if bookmarksManager.bookMarkCheck(for: news) {
            bookMarkButton.setBackgroundImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            bookMarkButton.tintColor = .systemYellow
            bookMarkChangeColor = true
        }
        
        if news.image_url != nil {
            pictureNews.kf.setImage(with: URL(string: news.image_url ?? ""))
        } else {
            pictureNews.image = UIImage(named: "city_6")
        }
        if news.category != nil {
            category.text = news.category?[0].capitalized
        } else {
            category.text = NSLocalizedString("worldTopic", comment: "")
        }
        if news.creator != nil {
            autorName.text = news.creator?[0]
        } else {
            autorName.text = NSLocalizedString("Jhon Doe", comment: "")
        }
        if news.title != nil {
            titleLabel.text = news.title
        } else {
            titleLabel.text = NSLocalizedString("Categories_Title2", comment: "")
        }
        if news.link != nil {
            linkNews = news.link
        } else {
            linkNews = ""
        }
        if news.content != nil {
            textDiscription.text = news.content
        } else {
            textDiscription.text = "Leads in individual states may change from one party to another as all the votes are counted. Select a state for detailed results, and select the Senate, House or Governor tabs to view those races. For more detailed state results click on the States A-Z links at the bottom of this page. Results source: NEP/Edison via Reuters. Leads in individual states may change from one party to another as all the votes are counted. Select a state for detailed results, and select the Senate, House or Governor tabs to view those races. For more detailed state results click on the States A-Z links at the bottom of this page. Results source: NEP/Edison via Reuters."
        }
        
    }
    
    
    
    @objc private func addToBookmarks() {
        if bookMarkChangeColor == false {
//            bookMarkButton.setBackgroundImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            bookMarkButton.setBackgroundImage(UIImage(systemName: "bookmark.fill"), for: .highlighted)
            bookMarkButton.tintColor = .systemYellow
            bookMarkChangeColor = true
            guard let data = news else { return }
            //print(data)
            bookmarksManager.saveNewsToDefaults(news: data)
        } else {
            bookMarkButton.tintColor = .white
            bookMarkChangeColor = false
            guard let data = news else { return }
            //print(data)
            bookmarksManager.deleteNewsFromDefaults(news: data)
        }
    }
    
    
    
    @objc func sharedAction() {
        guard let link = linkNews else { return }
        let shareController = UIActivityViewController(activityItems: [link], applicationActivities: nil)
        present(shareController, animated: true)
    }
    
    
    
    @objc func goBackAction() {
        navigationController?.popViewController(animated: true)
    }
    
    
}

extension NewsViewConroller {
    func layout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(pictureNews)
        contentView.addSubview(category)
        contentView.addSubview(bookMarkButton)
        contentView.addSubview(shareButton)
        contentView.addSubview(backButton)
        contentView.addSubview(titleLabel)
        contentView.addSubview(autorName)
        contentView.addSubview(autor)
        contentView.addSubview(textDiscription)
        backButton.addTarget(self, action: #selector(goBackAction), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            
            
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: -60),
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
            //            pictureNews.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            
            category.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -16),
            category.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            category.widthAnchor.constraint(greaterThanOrEqualToConstant: 90),
            category.heightAnchor.constraint(equalToConstant: 35),
            
//            backButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
//            backButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
//            backButton.widthAnchor.constraint(equalToConstant: 24),
//            backButton.heightAnchor.constraint(equalToConstant: 24),
            backButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            backButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 60),
            backButton.heightAnchor.constraint(equalToConstant: 50),
            backButton.widthAnchor.constraint(equalTo: backButton.heightAnchor),
            
            bookMarkButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 60),
            bookMarkButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            bookMarkButton.widthAnchor.constraint(equalToConstant: 50),
            bookMarkButton.heightAnchor.constraint(equalToConstant: 50),
            
            shareButton.topAnchor.constraint(equalTo: bookMarkButton.bottomAnchor, constant: 29),
            shareButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            shareButton.widthAnchor.constraint(equalToConstant: 50),
            shareButton.heightAnchor.constraint(equalToConstant: 50),
            
            titleLabel.bottomAnchor.constraint(equalTo: autorName.topAnchor, constant: -24),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            titleLabel.heightAnchor.constraint(equalToConstant: 60),
            
            autorName.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            autorName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 26),
            autorName.bottomAnchor.constraint(equalTo: pictureNews.bottomAnchor, constant: -48),
            
            autor.topAnchor.constraint(equalTo: autorName.bottomAnchor),
            autor.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 26),
            autor.bottomAnchor.constraint(equalTo: pictureNews.bottomAnchor, constant: -24),
            
            textDiscription.topAnchor.constraint(equalTo: pictureNews.bottomAnchor, constant: 20),
            textDiscription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            textDiscription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            textDiscription.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        ])
        
    }
    
}
