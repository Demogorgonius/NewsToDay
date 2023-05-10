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
    
    private let pictureNews: UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .red
        return image
    }()
    
    private let scrollView: UIScrollView = {
        let scroolView = UIScrollView()
        scroolView.showsVerticalScrollIndicator = true
        scroolView.alwaysBounceVertical = true
        scroolView.translatesAutoresizingMaskIntoConstraints = false
        return scroolView
    }()
    
    private let contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private let textDiscription: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.numberOfLines = 0
        text.font = UIFont(name: "Inter", size: 18)
//        text.font = .systemFont(ofSize: 22, weight: .regular)
        text.text = "Leads in individual states may change from one party to another as all the votes are counted. Select a state for detailed results, and select the Senate, House or Governor tabs to view those races. For more detailed state results click on the States A-Z links at the bottom of this page. Results source: NEP/Edison via Reuters. Leads in individual states may change from one party to another as all the votes are counted. Select a state for detailed results, and select the Senate, House or Governor tabs to view those races. For more detailed state results click on the States A-Z links at the bottom of this page. Results source: NEP/Edison via Reuters."
        return text
    }()
}

extension NewsViewConroller {
    func layout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(pictureNews)
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
            
            pictureNews.topAnchor.constraint(equalTo: scrollView.topAnchor),
            pictureNews.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            pictureNews.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            pictureNews.heightAnchor.constraint(equalToConstant: 350),
            
            textDiscription.topAnchor.constraint(equalTo: pictureNews.bottomAnchor, constant: 24),
            textDiscription.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            textDiscription.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            textDiscription.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -15)
        ])

    }

}
