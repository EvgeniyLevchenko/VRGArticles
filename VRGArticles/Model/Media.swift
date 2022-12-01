//
//  Media.swift
//  VRGTest
//
//  Created by QwertY on 01.12.2022.
//

import Foundation

// MARK: - Media
struct Media: Codable {
    let type: String
    let subtype: String
    let caption, copyright: String
    let approvedForSyndication: Int
    let mediaMetadata: [MediaMetadatum]

    enum CodingKeys: String, CodingKey {
        case type, subtype, caption, copyright
        case approvedForSyndication = "approved_for_syndication"
        case mediaMetadata = "media-metadata"
    }
}
