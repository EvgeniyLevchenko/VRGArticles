//
//  DataStoring.swift
//  VRGArticles
//
//  Created by QwertY on 06.12.2022.
//

import Foundation

protocol DataStoring {
    func saveArticle(_ article: Article, completion: @escaping (Error?) -> Void)
    func removeArticle(_ article: Article, completion: @escaping (Error?) -> Void)
    func getArticles(completion: @escaping (Result<[Article], Error>) -> Void)
}
