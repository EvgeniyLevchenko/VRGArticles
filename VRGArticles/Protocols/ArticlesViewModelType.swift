//
//  MainViewModelType.swift
//  VRGArticles
//
//  Created by QwertY on 01.12.2022.
//

import UIKit

typealias ArticlesDataSourceSnapshot = NSDiffableDataSourceSnapshot<ArticleType, Article>

protocol ArticlesViewModelType {
    var articles: Box<[Article]> { get }
    
    func fetchArticles(completion: @escaping (Error?) -> Void)
    func reloadDataSource(with searchText: String?, completion: @escaping (ArticlesDataSourceSnapshot) -> Void)
}
