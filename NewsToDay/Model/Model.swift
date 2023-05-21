//
//  Model.swift
//  NewsToDay
//
//  Created by Dmitry Medvedev on 16.05.2023.
//

import Foundation

struct NewsData: Codable {
    var status: String
    var totalResults: Int
    var results: [Results]
}

struct Results: Codable, Equatable {
    var title: String?
    var link: String?
    var creator: [String]?
    var description: String?
    var content: String?
    var image_url: String?
    var category: [String]?
}
