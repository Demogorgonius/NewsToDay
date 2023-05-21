
import Foundation

class BookMarksManager {
    
    let defaults = UserDefaults.standard
    var newsArray = [Results]()
    
    
//    @objc public func setUserDefaults(){
//        UserDefaults.resetStandardUserDefaults()
//        defaults.set(newsArray, forKey: "bookmark")
//
//    }
    
    func saveNewsToDefaults(news: Results) {
        var bookmarkArray: [Results] = []
        guard let bookmarks = defaults.data(forKey: "bookmark") else { return }
        do {
            let decoder = JSONDecoder()
            bookmarkArray = try decoder.decode([Results].self, from: bookmarks)
        } catch {
            print("ERROR!!!!!!!DECODE\(error)")
        }

        bookmarkArray.append(news)
        do {
            let result = bookmarkArray
            let encoder = JSONEncoder()
            let data = try encoder.encode(result)
            UserDefaults.standard.set(data, forKey: "bookmark")
        } catch {
            print(error)
        }
//        defaults.set(newsArrayNew, forKey: "bookmark")
        print(UserDefaults.standard.dictionaryRepresentation())
        print(getNewsFromUserDefaults())
    }
    
    func deleteNewsFromDefaults(news: Results) {
        
    }
    
    func getNewsFromUserDefaults() -> [Results]? {
        var bookmarkArray: [Results]?
        guard let bookmarks = defaults.data(forKey: "bookmark") else { return nil }
        do {
            let decoder = JSONDecoder()
            bookmarkArray = try decoder.decode([Results].self, from: bookmarks)
        } catch {
            print("ERROR!!!!!!!DECODE\(error)")
        }
        
        return bookmarkArray
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
