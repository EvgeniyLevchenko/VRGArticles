//
//  NetworkService.swift
//  VRGArticles
//
//  Created by QwertY on 01.12.2022.
//

import Foundation
import Alamofire

class NetworkService: Networking {

    static let shared = NetworkService()
    
    private var apiKey: String {
        get {
            let resourceName = "Articles-Info"
            let resourceType = "plist"
            guard let filePath = Bundle.main.path(
                forResource: resourceName,
                ofType: resourceType
            ) else {
                fatalError("Couldn't find file 'Articles-Info.plist'.")
            }
            
            let plist = NSDictionary(contentsOfFile: filePath)
            let key = "API_KEY"
            guard let value = plist?.object(forKey: key) as? String else {
                fatalError("Couldn't find key 'API_KEY' in 'Articles-Info.plist'.")
            }
            
            if (value.starts(with: "_")) {
                fatalError("Register for a TMDB developer account and get an API key at https://developers.themoviedb.org/3/getting-started/introduction.")
            }
            
            return value
        }
    }
    
    private init() {}
    
    private func getRequestURL(for article: ArticleType, period: Period) -> String {
        let urlBase = "https://api.nytimes.com/svc/mostpopular/v2/"
        let articleTypeStr = article.rawValue + "/"
        let periodStr = period.rawValue
        let urlEnding = ".json?api-key="
        let urlStr = urlBase + articleTypeStr + periodStr + urlEnding + apiKey
        return urlStr
    }

    func fetchArticles(of articleType: ArticleType, period: Period, completion: @escaping (Result<[Article], Error>) -> Void) {
        let url = getRequestURL(for: articleType, period: period)
        AF.request(url).responseDecodable(of: Response.self) { response in
            switch response.result {
            case .success(let response):
                let articles = response.articles
                completion(.success(articles))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
