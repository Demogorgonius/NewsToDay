import Foundation

protocol NewsManagerDelegate {
    func getNews()
    func didFailWithError(error: Error)
}

class NewsManager {
    
    private let session = URLSession.shared
    private let baseURLWithCategory = "https://newsapi.org/v2/top-headlines?"
    private let apiKey = "316ce50f67374ea4a3eea961af7b077d"
    
    var delegate: NewsManagerDelegate?
    
    func performRequest(category: String, completion: @escaping (Result <[Article], Error> ) -> ()) {
        
        let urlString = baseURLWithCategory + "apiKey=\(apiKey)" + "&category=\(category)"
        
        if let url = URL(string: urlString) {
            let task = session.dataTask(with: url, completionHandler: { data, response, error in
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let decodedData = try decoder.decode(NewsData.self, from: data)
                        completion(.success(decodedData.articles))
                    } catch {
                        completion(.failure(error))
                    }
                }
            })
            task.resume()
        }
    }
}
