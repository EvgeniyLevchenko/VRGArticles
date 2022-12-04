//
//  Article.swift
//  VRGTest
//
//  Created by QwertY on 01.12.2022.
//

import Foundation

// MARK: - Article
struct Article: Codable {
    let uri: String
    let url: String
    let id, assetID: Int
    let source: String
    let publishedDate, updated, section, subsection: String
    let nytdsection, adxKeywords: String
    let column: String?
    let byline: String
    let type: String
    let title, abstract: String
    let desFacet, orgFacet, perFacet, geoFacet: [String]
    let media: [Media]
    let etaID: Int

    enum CodingKeys: String, CodingKey {
        case uri, url, id
        case assetID = "asset_id"
        case source
        case publishedDate = "published_date"
        case updated, section, subsection, nytdsection
        case adxKeywords = "adx_keywords"
        case column, byline, type, title, abstract
        case desFacet = "des_facet"
        case orgFacet = "org_facet"
        case perFacet = "per_facet"
        case geoFacet = "geo_facet"
        case media
        case etaID = "eta_id"
    }
    
    func contains(filter: String?) -> Bool {
        guard let filter = filter else { return true }
        if filter.isEmpty { return true }
        let lowercasedFilter = filter.lowercased()
        return title.lowercased().contains(lowercasedFilter)
    }
}

extension Article: Hashable {
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
    
    static func == (lhs: Article, rhs: Article) -> Bool {
       return lhs.id == rhs.id
    }
}
