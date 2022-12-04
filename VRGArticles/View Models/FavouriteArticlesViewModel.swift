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
        
    }
}
