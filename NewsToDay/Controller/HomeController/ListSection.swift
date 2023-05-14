//
//  ListSection.swift
//  NewsToDay
//
//  Created by Dmitry Medvedev on 11.05.2023.
//

import Foundation

enum ListSection {
    case textField([ListItem])
    case topics([ListItem])
    case news([ListItem])
    case recommended([ListItem])
    
    var items: [ListItem] {
        switch self {
        case .textField(let items),
                .topics(let items),
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
        case .textField(_):
            return ""
        case .topics(_):
            return ""
        case .news(_):
            return ""
        case .recommended(_):
            return NSLocalizedString("headerRecommendedNews", comment: "")
        }
    }
}
