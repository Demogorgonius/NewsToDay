import Foundation

protocol NewsManagerDelegate {
    func getNews()
    func didFailWithError(error: Error)
}

class NewsManager {
    
    private let session = URLSession.shared
    private let baseURLWithCategory = "https://newsdata.io/api/1/news?"
    private let apiKey = "pub_22320bc7f5a0dbf1f1d8d522a311a889b2f9f"
    
    var delegate: NewsManagerDelegate?
    
    func performRequest(category: String, completion: @escaping (Result <[Results], Error> ) -> ()) {
        
        let urlString = baseURLWithCategory + "apikey=\(apiKey)" + "&category=\(category)" + "&language=en"
        
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
}
