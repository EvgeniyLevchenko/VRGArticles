//
//  MostSharedArticlesViewModel.swift
//  VRGArticles
//
//  Created by QwertY on 03.12.2022.
//

import UIKit

class MostSharedArticlesViewModel: ArticlesViewModelType {
    
    var articles: Box<[Article]> = Box([])
    
    func fetchArticles(completion: @escaping (Error?) -> Void) {
        NetworkService.shared.fetchArticles(of: .mostShared, period: .month) { result in
            switch result {
            case .success(let articles):
                self.articles.value = articles
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }

    func reloadDataSource(with searchText: String? = nil,completion: @escaping (ArticlesDataSourceSnapshot) -> Void) {
        var snapshot = ArticlesDataSourceSnapshot()
        snapshot.appendSections([.mostShared])
        snapshot.appendItems(articles.value, toSection: .mostShared)
        completion(snapshot)
    }
}
