//
//  Networking.swift
//  VRGArticles
//
//  Created by QwertY on 01.12.2022.
//

import Foundation
import Alamofire

protocol Networking {
    func fetchArticles(of articleType: ArticleType, period: Period, completion: @escaping(Result<[Article], Error>) -> Void)
}
