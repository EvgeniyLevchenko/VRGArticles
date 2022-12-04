//
//  MostEmailedArticlesViewModel.swift
//  VRGArticles
//
//  Created by QwertY on 03.12.2022.
//

import UIKit

class MostEmailedArticlesViewModel: ArticlesViewModelType {
    
    var articles: Box<[Article]> = Box([])
    
    func fetchArticles(completion: @escaping (Error?) -> Void) {
        NetworkService.shared.fetchArticles(of: .mostEmailed, period: .month) { result in
            switch result {
            case .success(let articles):
                self.articles.value = articles
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }

    func reloadDataSource(with searchText: String? = nil, completion: @escaping (ArticlesDataSourceSnapshot) -> Void) {
        var snapshot = ArticlesDataSourceSnapshot()
        snapshot.appendSections([.mostEmailed])
        snapshot.appendItems(articles.value, toSection: .mostEmailed)
        completion(snapshot)
    }
}

