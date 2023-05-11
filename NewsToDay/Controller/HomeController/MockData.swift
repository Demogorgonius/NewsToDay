//
//  MockData.swift
//  NewsToDay
//
//  Created by Dmitry Medvedev on 11.05.2023.
//

import Foundation

struct MockData {
    
    static let shared = MockData()
    
    private let topics: ListSection = {
        .topics([.init(rightTitle: "", leftTitle: "", image: "", categories: "Random", newsTopic: "", news: ""),
                 .init(rightTitle: "", leftTitle: "", image: "", categories: "Sports", newsTopic: "", news: ""),
                 .init(rightTitle: "", leftTitle: "", image: "", categories: "Gaming", newsTopic: "", news: ""),
                 .init(rightTitle: "", leftTitle: "", image: "", categories: "Politics", newsTopic: "", news: "")])
    }()
    
    private let news: ListSection = {
        .news([.init(rightTitle: "", leftTitle: "", image: "0", categories: "", newsTopic: "", news: ""),
               .init(rightTitle: "", leftTitle: "", image: "1", categories: "", newsTopic: "", news: ""),
               .init(rightTitle: "", leftTitle: "", image: "2", categories: "", newsTopic: "", news: ""),
               .init(rightTitle: "", leftTitle: "", image: "3", categories: "", newsTopic: "", news: "")])
    }()
    
    private let recommended: ListSection = {
        .recommended([.init(rightTitle: "", leftTitle: "", image: "0", categories: "", newsTopic: "UI/UX Design", news: "A Simple Trick For Creating Color Palettes Quickly"),
                      .init(rightTitle: "", leftTitle: "", image: "1", categories: "", newsTopic: "Art", news: "Six steps to creating a color palette"),
                      .init(rightTitle: "", leftTitle: "", image: "2", categories: "", newsTopic: "Colors", news: "Creating Color Palette from world around you"),
                      .init(rightTitle: "", leftTitle: "", image: "3", categories: "", newsTopic: "", news: "")])
    }()
    
    var pageData: [ListSection] {
        [topics, news, recommended]
    }
}
