//
//  ListSection.swift
//  NewsToDay
//
//  Created by Dmitry Medvedev on 11.05.2023.
//

import Foundation

enum ListSection {
    case topics([ListItem])
    case news([ListItem])
    case recommended([ListItem])
    
    var items: [ListItem] {
        switch self {
        case .topics(let items),
                .news(let items),
                .recommended(let items):
            return items
        }
    }
    
    var count: Int {
        return items.count
    }
    
    var title: String {
        switch self {
        case .topics(_):
            return ""
        case .news(_):
            return ""
        case .recommended(_):
            return "Recommended for you"
        }
    }
}
