//
//  ArticleItem+CoreDataClass.swift
//  VRGArticles
//
//  Created by QwertY on 05.12.2022.
//
//

import Foundation
import CoreData

@objc(ArticleItem)
public class ArticleItem: NSManagedObject {
    var article: Article {
        get {
            let metadata: [MediaMetadatum] = [
                MediaMetadatum(url: standartImageURL ?? "",
                               format: "",
                               height: 75,
                               width: 75),
                MediaMetadatum(url: mediumImageURL ?? "",
                               format: "",
                               height: 293,
                               width: 440)
            ]
            
            let media = Media(
                type: "",
                subtype: "",
                caption: "",
                copyright: "",
                approvedForSyndication: 0,
                mediaMetadata: metadata)
            
            let article = Article(
                uri: "",
                url: "",
                id: Int(id),
                assetID: 0,
                source: "",
                publishedDate: publishedDate ?? "",
                updated: "",
                section: section ?? "",
                subsection: "",
                nytdsection: "",
                adxKeywords: "",
                column: "",
                byline: authorName ?? "",
                type: "",
                title: title ?? "",
                abstract: summary ?? "",
                desFacet: [],
                orgFacet: [],
                perFacet: [],
                geoFacet: [],
                media: [media],
                etaID: 0
            )
            
            return article
        }
        set {
            let standartImageURL = newValue.media.first?.mediaMetadata.first?.url
            let mediumImageURL = newValue.media.first?.mediaMetadata.last?.url
            self.standartImageURL = standartImageURL
            self.mediumImageURL = mediumImageURL
            self.id = Int64(newValue.id)
            self.title = newValue.title
            self.authorName = newValue.byline
            self.section = newValue.section
            self.summary = newValue.abstract
            self.publishedDate = newValue.publishedDate
        }
    }
}
