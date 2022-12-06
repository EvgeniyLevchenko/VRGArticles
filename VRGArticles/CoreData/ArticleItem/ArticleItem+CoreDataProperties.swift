//
//  ArticleItem+CoreDataProperties.swift
//  VRGArticles
//
//  Created by QwertY on 05.12.2022.
//
//

import Foundation
import CoreData


extension ArticleItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ArticleItem> {
        return NSFetchRequest<ArticleItem>(entityName: "ArticleItem")
    }

    @NSManaged public var id: Int64
    @NSManaged public var standartImageURL: String?
    @NSManaged public var title: String?
    @NSManaged public var authorName: String?
    @NSManaged public var section: String?
    @NSManaged public var summary: String?
    @NSManaged public var publishedDate: String?
    @NSManaged public var mediumImageURL: String?
}
