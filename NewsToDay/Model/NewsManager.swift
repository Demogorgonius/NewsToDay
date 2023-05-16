import Foundation

protocol NewsManagerDelegate {
    func getNews()
    func didFailWithError(error: Error)
}

class NewsManager {
    
    let baseURLWithCategory = "https://newsapi.org/v2/top-headlines?"
    let apiKey = "316ce50f67374ea4a3eea961af7b077d"
    
    var delegate: NewsManagerDelegate?
    
    var newsData = [Article]()
    
//    func getNews(for category: String) {
//        let request = baseURLWithCategory + "apiKey=\(apiKey)" + "&category=\(category)"
//        performRequest(with: request)
//        print(request)
//    }
    
//    func getNews() {
//        performRequest { data in
//            self.newsData = data
//            print(data)
//        }
//    }
    
    func performRequest(completion: @escaping (Result < [Article], Error > ) -> ()) {
        
        //1. Create a URL
        let urlString = "https://newsapi.org/v2/top-headlines?" + "apiKey=\(apiKey)" + "&category=general"
        if let url = URL(string: urlString) {
            //2. Create a URLSession
            let session = URLSession.shared
            
            //3. Give the session task
            let task = session.dataTask(with: url, completionHandler: { data, response, error in
                guard error == nil else {
//                    self.delegate?.didFailWithError(error: error!)
                    completion(.failure(error!))
                    return
                }
                
//                if let safeData = data {
//                    self.parseJSON(safeData)
                    let decoder = JSONDecoder()
                    do{
                        let decodedData = try decoder.decode(NewsData.self, from: data!)
//                        print(decodedData)
                        completion(.success(decodedData.articles))
                        
                        //надо сделать проходку по массиву
                        //self.newsData = decodedData.articles
            //            let author = decodedData.articles[0].author
            //            let title = decodedData.articles[0].title
            //            let descriprion = decodedData.articles[0].description
            //            let imageURL = decodedData.articles[0].urlToImage
            //            let content = decodedData.articles[0].content
                        
            //            delegate?.updateNews(model: NewsModel(author: author ?? "hz", title: title ?? "hz", description: descriprion ?? "hz", urlToImage: imageURL ?? "hz", content: content ?? "hz"))
                        
                    } catch {
                        self.delegate?.didFailWithError(error: error)
                    }
//                }
            })
            //4. Start the task
            task.resume()
        }
    }
    
//    func parseJSON(_ data: Data) {
//        let decoder = JSONDecoder()
//        do{
//            let decodedData = try decoder.decode(NewsData.self, from: data)
//
//            //надо сделать проходку по массиву
//            //self.newsData = decodedData.articles
////            let author = decodedData.articles[0].author
////            let title = decodedData.articles[0].title
////            let descriprion = decodedData.articles[0].description
////            let imageURL = decodedData.articles[0].urlToImage
////            let content = decodedData.articles[0].content
//
////            delegate?.updateNews(model: NewsModel(author: author ?? "hz", title: title ?? "hz", description: descriprion ?? "hz", urlToImage: imageURL ?? "hz", content: content ?? "hz"))
//
//        } catch {
//            delegate?.didFailWithError(error: error)
//        }
//    }
}

struct NewsData: Decodable {
    var status: String
    var totalResults: Int
    var articles: [Article]
}

struct Article: Decodable {
    var author: String?
    var title: String?
    var description: String?
    var urlToImage: String?
    var publishedAt: String
    var content: String?
}

struct NewsModel {
    var author: String
    var title: String
    var description: String
    var urlToImage: String
    var content: String
}
