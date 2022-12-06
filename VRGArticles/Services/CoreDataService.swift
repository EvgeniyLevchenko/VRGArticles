//
//  CoreDataService.swift
//  VRGArticles
//
//  Created by QwertY on 05.12.2022.
//

import UIKit
import CoreData

class CoreDataService: DataStoring {
    
    static let shared = CoreDataService()
    
    private var context: NSManagedObjectContext? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        return appDelegate.persistentContainer.viewContext
    }
    
    private init() {}
    
    func saveArticle(_ article: Article, completion: @escaping (Error?) -> Void) {
        guard let context = context else {
            completion(CoreDataError.cannotGetContext)
            return
        }
        
        let newArticleItem = ArticleItem(context: context)
        newArticleItem.article = article
        
        do {
            try context.save()
        } catch {
            completion(error)
            return
        }
        completion(nil)
    }
    
    func removeArticle(_ article: Article, completion: @escaping (Error?) -> Void) {
        do {
            if let articleItems = try context?.fetch(ArticleItem.fetchRequest()),
               let articleItem = articleItems.filter({ $0.article.id == article.id }).first {
                context?.delete(articleItem)
            }
        } catch {
            completion(CoreDataError.cannotAccessData)
            return
        }
        completion(nil)
    }
    
    func getArticles(completion: @escaping (Result<[Article], Error>) -> Void) {
        do {
            if let articleItems = try context?.fetch(ArticleItem.fetchRequest()) {
                let articles = articleItems.map { $0.article }
                completion(.success(articles))
                return
            }
        } catch {
            completion(.failure(CoreDataError.cannotAccessData))
            return
        }
        completion(.failure(CoreDataError.cannotAccessData))
    }
}

