//
//  Model.swift
//  NewsToDay
//
//  Created by Dmitry Medvedev on 16.05.2023.
//

import Foundation

struct NewsData: Decodable {
    var status: String
    var totalResults: Int
    var articles: [Article]
}

struct Article: Decodable {
    var author: String?
    var title: String?
    var description: String?
    var urlToImage: String?
    var publishedAt: String
    var content: String?
}

struct NewsModel {
    var author: String
    var title: String
    var description: String
    var urlToImage: String
    var content: String
}
