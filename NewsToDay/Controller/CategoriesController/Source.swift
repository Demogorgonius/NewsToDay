//
import UIKit
struct Source {
    static func allCategories() -> [Category] {
        [
            .init(emojiString: "🎰",categoryName: NSLocalizedString("Categories_cell1", comment: "")),
            .init(emojiString: "🎭",categoryName: NSLocalizedString("Categories_cell2", comment: "")),
            .init(emojiString: "🏥",categoryName: NSLocalizedString("Categories_cell3", comment: "")),
            .init(emojiString: "📚",categoryName: NSLocalizedString("Categories_cell4", comment: "")),
            .init(emojiString: "⚽️",categoryName: NSLocalizedString("Categories_cell5", comment: "")),
            .init(emojiString: "🖥️",categoryName: NSLocalizedString("Categories_cell6", comment: "")),
            .init(emojiString: "🐿️",categoryName: NSLocalizedString("Categories_cell7", comment: "")),
            .init(emojiString: "🍗",categoryName: NSLocalizedString("Categories_cell8", comment: "")),
            .init(emojiString: "🏛️",categoryName: NSLocalizedString("Categories_cell9", comment: "")),
            .init(emojiString: "🥾",categoryName: NSLocalizedString("Categories_cell10", comment: ""))
        ]
    }
    
}

struct Category {
    var emojiString: String
    var categoryName: String
}
