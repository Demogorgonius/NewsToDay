//
//  ViewController.swift
//  NewsToDay
//
//  Created by Sergey on 07.05.2023.
//

import UIKit

class ViewController: UIViewController, NewsManagerDelegate {

    var newsManager = NewsManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        newsManager.delegate = self
        newsManager.getNews(for: "sports")
        view.backgroundColor = .red
    }
    func updateNews(model: NewsModel) {
        print(model)
//        DispatchQueue.main.async {
//            self.descriptionLabel.text = model.description
//            self.authorLabel.text = model.author
//            self.contentLabel.text = model.content
//            self.titleLabel.text = model.title
//        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }


}

