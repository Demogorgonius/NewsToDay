
import Foundation

class BookMarksManager {
    
    let defaults = UserDefaults.standard
    var newsArray = [Results]()
    
    
    @objc public func setUserDefaults(){
        UserDefaults.resetStandardUserDefaults()
        defaults.set(newsArray, forKey: "bookmark")
        
    }
    
    func getNewsFromUserDefaults() -> [Any] {
        if let result = defaults.array(forKey: "bookmark"){
            return result
        }
        return []
    }
    
    func bookMarkCheck(for text: String) -> Bool {
        var isSaved = false
        if let data = defaults.array(forKey: "bookmark") {
            let array = data as! [Results]
            for element in array {
                if element.content == text {
                    isSaved = true
                }
            }
        }
        return isSaved
    }
}
