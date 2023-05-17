import Foundation

class CategoriesManager {
    
    let defaults = UserDefaults.standard
    var setOfCategories = [String]()
    
    @objc public func setUserDefaults(){
        UserDefaults.resetStandardUserDefaults()
        defaults.set(setOfCategories, forKey: "categories")
    }
    
    func getCategories() -> [Any] {
        if let result = defaults.array(forKey: "categories"){
            print(result)
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
}
