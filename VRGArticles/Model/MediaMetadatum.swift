//
//  MediaMetadatum.swift
//  VRGTest
//
//  Created by QwertY on 01.12.2022.
//

import Foundation

// MARK: - MediaMetadatum
struct MediaMetadatum: Codable {
    let url: String
    let format: String
    let height, width: Int
}
