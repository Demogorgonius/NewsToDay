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
    
    let topics: ListSection = {
        .topics([.init(image: "", categories: NSLocalizedString("worldTopic", comment: ""), newsTopic: "", news: ""),
                 .init(image: "", categories: NSLocalizedString("sportTopic", comment: ""), newsTopic: "", news: ""),
                 .init(image: "", categories: NSLocalizedString("healthTopic", comment: ""), newsTopic: "", news: ""),
                 .init(image: "", categories: NSLocalizedString("businessTopic", comment: ""), newsTopic: "", news: ""),
                 .init(image: "", categories: NSLocalizedString("politicsTopic", comment: ""), newsTopic: "", news: ""),
                 .init(image: "", categories: NSLocalizedString("foodTopic", comment: ""), newsTopic: "", news: ""),
                 .init(image: "", categories: NSLocalizedString("scienceTopic", comment: ""), newsTopic: "", news: ""),
                 .init(image: "", categories: NSLocalizedString("technologyTopic", comment: ""), newsTopic: "", news: ""),
                 .init(image: "", categories: NSLocalizedString("entertainmentTopic", comment: ""), newsTopic: "", news: ""),
                 .init(image: "", categories: NSLocalizedString("tourismTopic", comment: ""), newsTopic: "", news: ""),
                 .init(image: "", categories: NSLocalizedString("environmentTopic", comment: ""), newsTopic: "", news: "")])
    }()
    
    private let news: ListSection = {
        .news([.init(image: "", categories: "", newsTopic: "", news: ""),
               .init(image: "", categories: "", newsTopic: "", news: ""),
               .init(image: "", categories: "", newsTopic: "", news: ""),
               .init(image: "", categories: "", newsTopic: "", news: "")])
    }()
    
    private let recommended: ListSection = {
        .recommended([.init(image: "", categories: "", newsTopic: "", news: ""),
                      .init(image: "", categories: "", newsTopic: "", news: ""),
                      .init(image: "", categories: "", newsTopic: "", news: ""),
                      .init(image: "", categories: "", newsTopic: "", news: "")])
    }()
    
    var pageData: [ListSection] {
        [textField, topics, news, recommended]
    }
}
