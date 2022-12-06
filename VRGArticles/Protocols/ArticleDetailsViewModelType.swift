//
//  ArticleDetailsViewModelType.swift
//  VRGArticles
//
//  Created by QwertY on 05.12.2022.
//

import UIKit

protocol ArticleDetailsViewModelType {
    var article: Article { get }
    var isArticleSaved: Bool { get }
    var articleImageURL: URL? { get }
    var articleTitle: String { get }
    var articleAuthor: String { get }
    var articleSection: String { get }
    var articleSummary: String { get }
    var articlePublishedDate: String { get }

    func addArticleToFavourites(completion: @escaping (Error?) -> Void)
    func removeArticleFromFavourites(completion: @escaping (Error?) -> Void)
    func downloadImage(completion: @escaping (UIImage?) -> Void)
}
