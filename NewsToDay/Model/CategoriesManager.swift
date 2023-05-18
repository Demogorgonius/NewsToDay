import Foundation

class CategoriesManager {
    
    let defaults = UserDefaults.standard
    var setOfCategories = [String]()
    var selectedCategories = 0
    
    @objc public func setUserDefaults(){
        UserDefaults.resetStandardUserDefaults()
        defaults.set(setOfCategories, forKey: "categories")
    }
    
    func getCategories() -> [Any] {
        if let result = defaults.array(forKey: "categories"){
            return result
        }
        return [""]
    }
    
    func getRightCategory(buttonTitle: String) -> String{
        switch buttonTitle {
        case "🥾  \(NSLocalizedString("Categories_cell10", comment: ""))":
            return "tourism"
        case "🐿️  \(NSLocalizedString("Categories_cell7", comment: ""))":
            return "environment"
        case "🍗  \(NSLocalizedString("Categories_cell8", comment: ""))":
            return "food"
        case "🏛️  \(NSLocalizedString("Categories_cell9", comment: ""))":
            return "politics"
        case "🖥️  \(NSLocalizedString("Categories_cell6", comment: ""))":
            return "technology"
        case "📚  \(NSLocalizedString("Categories_cell4", comment: ""))":
            return "science"
        case "🎭  \(NSLocalizedString("Categories_cell2", comment: ""))":
            return "entertaiment"
        case "🎰  \(NSLocalizedString("Categories_cell1", comment: ""))":
            return "business"
        case "🏥  \(NSLocalizedString("Categories_cell3", comment: ""))":
            return "health"
        case "⚽️  \(NSLocalizedString("Categories_cell5", comment: ""))":
            return "sports"
        default:
            return "unexpected case"
        }
    }
    
    func getRightTitle(category: String) -> String {
        switch category {
        case "tourism":
            return "🥾  \(NSLocalizedString("Categories_cell10", comment: ""))"
        case "environment":
            return "🐿️  \(NSLocalizedString("Categories_cell7", comment: ""))"
        case "food":
            return "🍗  \(NSLocalizedString("Categories_cell8", comment: ""))"
        case "politics":
            return "🏛️  \(NSLocalizedString("Categories_cell9", comment: ""))"
        case "technology":
            return "🖥️  \(NSLocalizedString("Categories_cell6", comment: ""))"
        case "science":
            return "📚  \(NSLocalizedString("Categories_cell4", comment: ""))"
        case "entertaiment":
            return "🎭  \(NSLocalizedString("Categories_cell2", comment: ""))"
        case "business":
            return "🎰  \(NSLocalizedString("Categories_cell1", comment: ""))"
        case "health":
            return "🏥  \(NSLocalizedString("Categories_cell3", comment: ""))"
        case "sports":
            return "⚽️  \(NSLocalizedString("Categories_cell5", comment: ""))"
        default:
            return "unexpected case"
        }
    }
}
