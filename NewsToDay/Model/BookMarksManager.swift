
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
        var bookmarksArray: [Results] = []
        if let bookmarks = defaults.data(forKey: "bookmark") {
            do {
                let decoder = JSONDecoder()
                bookmarksArray = try decoder.decode([Results].self, from: bookmarks)
            } catch {
                print("ERROR!!!!!!!DECODE\(error)")
            }
        }

        bookmarksArray.append(news)
        do {
            let result = bookmarksArray
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
        var bookmarksArray: [Results] = []
        guard let bookmarks = defaults.data(forKey: "bookmark") else { return }
        do {
            let decoder = JSONDecoder()
            bookmarksArray = try decoder.decode([Results].self, from: bookmarks)
        } catch {
            print("ERROR!!!!!!!DECODE\(error)")
        }
        
        if let index = bookmarksArray.firstIndex(of: news) {
            bookmarksArray.remove(at: index)
        }
        
        do {
            let result = bookmarksArray
            let encoder = JSONEncoder()
            let data = try encoder.encode(result)
            UserDefaults.standard.set(data, forKey: "bookmark")
        } catch {
            print(error)
        }
        
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
    
    func bookMarkCheck(for news: Results) -> Bool {
        var isSaved = false
        var bookmarkArray: [Results]?
        guard let bookmarks = defaults.data(forKey: "bookmark") else { return false }
        do {
            let decoder = JSONDecoder()
            bookmarkArray = try decoder.decode([Results].self, from: bookmarks)
            
        } catch {
            print("ERROR!!!!!!!DECODE\(error)")
        }
        
        if let bookmarkArray = bookmarkArray {
            for new in bookmarkArray {
                if new == news {
                    isSaved = true
                }
            }
        }
        
        return isSaved
    }
}
