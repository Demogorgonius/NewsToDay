import Foundation

protocol NewsManagerDelegate {
    func getNews()
    func didFailWithError(error: Error)
}

class NewsManager {
    
    private let session = URLSession.shared
    private let baseURLWithCategory = "https://newsdata.io/api/1/news?"
    private let apiKey = "pub_22485dae15b45670dc08638a81e849c1c22e6"

    
    var delegate: NewsManagerDelegate?
    
    func performRequest(category: String, completion: @escaping (Result <[Results], Error> ) -> ()) {
        
        let urlString = baseURLWithCategory + "apikey=\(apiKey)" + "&category=\(category)" + "\(setLang())"
        
        if let url = URL(string: urlString) {
            let task = session.dataTask(with: url, completionHandler: { data, response, error in
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let decodedData = try decoder.decode(NewsData.self, from: data)
                        completion(.success(decodedData.results))
                    } catch {
                        completion(.failure(error))
                    }
                }
            })
            task.resume()
        }
    }
    
    func performRequest(textFieldText: String, completion: @escaping (Result <[Results], Error> ) -> ()) {
        
        let urlString = baseURLWithCategory + "apikey=\(apiKey)" + "&q=\(textFieldText)"
        
        if let url = URL(string: urlString) {
            let task = session.dataTask(with: url, completionHandler: { data, response, error in
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let decodedData = try decoder.decode(NewsData.self, from: data)
                        completion(.success(decodedData.results))
                    } catch {
                        completion(.failure(error))
                    }
                }
            })
            task.resume()
        }
    }
    
    private func setLang() -> String {
        var lang = ""

        let appLang = UserDefaults.standard.value(forKey: "AppleLanguages") as! [String]
        
        if appLang[0] == "ru-RU" {
            lang = "&language=ru"
        } else {
            lang = "&language=en"
        }
        
        return lang
    }
}
