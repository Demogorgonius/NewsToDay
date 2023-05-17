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
        .topics([.init(image: "", categories: NSLocalizedString("randomTopic", comment: ""), newsTopic: "", news: ""),
                 .init(image: "", categories: NSLocalizedString("sportTopic", comment: ""), newsTopic: "", news: ""),
                 .init(image: "", categories: NSLocalizedString("healthTopic", comment: ""), newsTopic: "", news: ""),
                 .init(image: "", categories: NSLocalizedString("businessTopic", comment: ""), newsTopic: "", news: ""),
                 .init(image: "", categories: NSLocalizedString("scienceTopic", comment: ""), newsTopic: "", news: ""),
                 .init(image: "", categories: NSLocalizedString("technologyTopic", comment: ""), newsTopic: "", news: ""),
                 .init(image: "", categories: NSLocalizedString("entertainmentTopic", comment: ""), newsTopic: "", news: "")])
    }()
    
    private let news: ListSection = {
        .news([.init(image: "0", categories: "", newsTopic: NSLocalizedString("UI/UX DESIGN", comment: ""), news: "A Simple Trick For Creating Color Palettes Quickly"),
               .init(image: "1", categories: "", newsTopic: NSLocalizedString("ART", comment: ""), news: "Six steps to creating a color palette"),
               .init(image: "2", categories: "", newsTopic: NSLocalizedString("COLORS", comment: ""), news: "Creating Color Palette from world around you"),
               .init(image: "3", categories: "", newsTopic: NSLocalizedString("POLITICS", comment: ""), news: "The latest situation in the presidential election")])
    }()
    
    private let recommended: ListSection = {
        .recommended([.init(image: "0", categories: "", newsTopic: NSLocalizedString("ui/ux design", comment: ""), news: "A Simple Trick For Creating Color Palettes Quickly"),
                      .init(image: "1", categories: "", newsTopic: NSLocalizedString("art", comment: ""), news: "Six steps to creating a color palette"),
                      .init(image: "2", categories: "", newsTopic: NSLocalizedString("colors", comment: ""), news: "Creating Color Palette from world around you"),
                      .init(image: "3", categories: "", newsTopic: NSLocalizedString("politics", comment: ""), news: "The latest situation in the presidential election")])
    }()
    
    var pageData: [ListSection] {
        [textField, topics, news, recommended]
    }
}
