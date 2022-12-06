//
//  CoreDataError.swift
//  VRGArticles
//
//  Created by QwertY on 05.12.2022.
//

import Foundation

enum CoreDataError: Error {
    case cannotGetContext
    case cannotGetUser
    case cannotAccessData
}

extension CoreDataError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .cannotGetContext:
            return NSLocalizedString("Cannot access context", comment: "")
        case .cannotGetUser:
            return NSLocalizedString("Cannot access user", comment: "")
        case .cannotAccessData:
            return NSLocalizedString("Cannot access data", comment: "")
        }
    }
}
