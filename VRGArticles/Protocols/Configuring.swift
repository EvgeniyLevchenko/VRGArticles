//
//  Configuring.swift
//  VRGArticles
//
//  Created by QwertY on 03.12.2022.
//

import Foundation

protocol Configuring {
    static var reuseID: String { get }
    
    func configure<T: Hashable>(with article: T)
}
