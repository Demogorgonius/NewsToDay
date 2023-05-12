//
//  MockData.swift
//  NewsToDay
//
//  Created by Dmitry Medvedev on 11.05.2023.
//

import Foundation

struct MockData {
    
    static let shared = MockData()
    
    private let textField: ListSection = {
        .textField([.init(image: "", categories: "", newsTopic: "", news: "")])
    }()
    
    private let topics: ListSection = {
        .topics([.init(image: "", categories: "Random", newsTopic: "", news: ""),
                 .init(image: "", categories: "Sports", newsTopic: "", news: ""),
                 .init(image: "", categories: "Gaming", newsTopic: "", news: ""),
                 .init(image: "", categories: "Politics", newsTopic: "", news: "")])
    }()
    
    private let news: ListSection = {
        .news([.init(image: "0", categories: "", newsTopic: "", news: ""),
               .init(image: "1", categories: "", newsTopic: "", news: ""),
               .init(image: "2", categories: "", newsTopic: "", news: ""),
               .init(image: "3", categories: "", newsTopic: "", news: "")])
    }()
    
    private let recommended: ListSection = {
        .recommended([.init(image: "0", categories: "", newsTopic: "UI/UX Design", news: "A Simple Trick For Creating Color Palettes Quickly"),
                      .init(image: "1", categories: "", newsTopic: "Art", news: "Six steps to creating a color palette"),
                      .init(image: "2", categories: "", newsTopic: "Colors", news: "Creating Color Palette from world around you"),
                      .init(image: "3", categories: "", newsTopic: "Politics", news: "The latest situation in the presidential election")])
    }()
    
    var pageData: [ListSection] {
        [textField, topics, news, recommended]
    }
}
