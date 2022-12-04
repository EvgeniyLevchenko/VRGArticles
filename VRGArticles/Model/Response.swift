//
//  Response.swift
//  VRGTest
//
//  Created by QwertY on 01.12.2022.
//

import Foundation

// MARK: - Response
struct Response: Codable {
    let status, copyright: String
    let numResults: Int
    let articles: [Article]

    enum CodingKeys: String, CodingKey {
        case status, copyright
        case numResults = "num_results"
        case articles = "results"
    }
}
