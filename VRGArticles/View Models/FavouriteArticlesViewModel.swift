//
//  FavouriteArticlesViewModel.swift
//  VRGArticles
//
//  Created by QwertY on 03.12.2022.
//

import UIKit

class FavouriteArticlesViewModel: ArticlesViewModelType {
    
    var articles: Box<[Article]> = Box([])
    
    func fetchArticles(completion: @escaping (Error?) -> Void) {
        
    }

    func reloadDataSource(with searchText: String? = nil,completion: @escaping (ArticlesDataSourceSnapshot) -> Void) {
        let filtered = articles.value.filter { article in
            article.contains(filter: searchText)
        }
        
        var snapshot = ArticlesDataSourceSnapshot()
        snapshot.appendSections([.favourites])
        snapshot.appendItems(filtered, toSection: .favourites)
        completion(snapshot)
    }
}
