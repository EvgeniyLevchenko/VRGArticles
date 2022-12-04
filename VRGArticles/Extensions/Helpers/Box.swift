//
//  Box.swift
//  VRGArticles
//
//  Created by QwertY on 02.12.2022.
//

import Foundation

class Box<T> {
    typealias Listener = () -> ()
    
    var listener: Listener?
    
    var value: T {
        didSet {
            listener?()
        }
    }
    
    func bind(listener: @escaping Listener) {
        self.listener = listener
        listener()
    }
    
    init(_ value: T) {
        self.value = value
    }
}
