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
    var results: [Results]
}

struct Results: Decodable {
    var title: String?
    var creator: [String]?
    var description: String?
    var content: String?
    var image_url: String?
}
