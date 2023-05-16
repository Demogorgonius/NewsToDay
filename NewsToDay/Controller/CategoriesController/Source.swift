//
import UIKit
struct Source {
    static func allCategories() -> [Category] {
        [
            .init(emojiString: "🎰",categoryName: "Business"),
            .init(emojiString: "🎭",categoryName: "Entertainment"),
            .init(emojiString: "🏥",categoryName: "Health"),
            .init(emojiString: "📚",categoryName: "Science"),
            .init(emojiString: "⚽️",categoryName: "Sports"),
            .init(emojiString: "🖥️",categoryName: "Technology")
        ]
    }
    
}

struct Category {
    var emojiString: String
    var categoryName: String
}
