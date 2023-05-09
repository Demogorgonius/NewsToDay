import Foundation

protocol NewsManagerDelegate {
    func updateNews(model: NewsModel)
    func didFailWithError(error: Error)
}

struct NewsManager {
    
    let baseURLWithCategory = "https://newsapi.org/v2/top-headlines?"
    let apiKey = "316ce50f67374ea4a3eea961af7b077d"
    
    var delegate: NewsManagerDelegate?
    
    func getNews(for category: String) {
        let request = baseURLWithCategory + "apiKey=\(apiKey)" + "&country=\(category)"
        performRequest(with: request)
    }
    
    func performRequest(with urlString: String) {
        
        //1. Create a URL
        if let url = URL(string: urlString) {
            //2. Create a URLSession
            let session = URLSession(configuration: .default)
            
            //3. Give the session task
            let task = session.dataTask(with: url, completionHandler: { data, response, error in
                guard error == nil else {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    parseJSON(safeData)
                }
            })
            //4. Start the task
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(NewsData.self, from: data)
            
            //надо сделать проходку по массиву
            let author = decodedData.articles[0].author
            let title = decodedData.articles[0].title
            let descriprion = decodedData.articles[0].description
            let imageURL = decodedData.articles[0].urlToImage
            let content = decodedData.articles[0].content
            
            delegate?.updateNews(model: NewsModel(author: author ?? "hz", title: title ?? "hz", description: descriprion ?? "hz", urlToImage: imageURL ?? "hz", content: content ?? "hz"))
            
        } catch {
            delegate?.didFailWithError(error: error)
        }
    }
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
