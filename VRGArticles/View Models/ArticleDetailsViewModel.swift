//
//  ArticleDetailsViewModel.swift
//  VRGArticles
//
//  Created by QwertY on 05.12.2022.
//

import UIKit
import SDWebImage

class ArticleDetailsViewModel: ArticleDetailsViewModelType {
    var article: Article
    
    var isArticleSaved: Bool {
        var savedArticles: [Article] = []
        CoreDataService.shared.getArticles { result in
            switch result {
            case .success(let articles):
                savedArticles = articles
            case .failure(_):
                break;
            }
        }
        return savedArticles.contains(where: { $0.id == article.id })
    }
    
    var articleImageURL: URL? {
        if let strURL = article.media.first?.mediaMetadata.last?.url {
            return URL(string: strURL)
        }
        return nil
    }
    
    var articleTitle: String {
        article.title
    }
    
    var articleAuthor: String {
        article.byline
    }
    
    var articleSection: String {
        article.section
    }
    
    var articleSummary: String {
        article.abstract
    }
    
    var articlePublishedDate: String {
        article.publishedDate
    }
    
    init(article: Article) {
        self.article = article
    }
    
    func addArticleToFavourites(completion: @escaping (Error?) -> Void) {
        CoreDataService.shared.saveArticle(article) { error in
            if let error = error {
                completion(error)
                return
            }
            completion(nil)
        }
    }
    
    func removeArticleFromFavourites(completion: @escaping (Error?) -> Void) {
        CoreDataService.shared.removeArticle(article) { error in
            if let error = error {
                completion(error)
                return
            }
            completion(nil)
        }
    }
    
    func downloadImage(completion: @escaping (UIImage?) -> Void) {
        if let url = articleImageURL {
            let imageView = UIImageView()
            imageView.sd_setImage(with: url) { image, error, _, _ in
                if let image = image {
                    completion(image)
                } else {
                    completion(nil)
                }
            }
        } else {
            completion(nil)
        }
    }
}
