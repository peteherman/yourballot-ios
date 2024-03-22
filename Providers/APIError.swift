//
//  APIError.swift
//  Your Ballot
//
//  Created by Peter Herman on 3/19/24.
//

import Foundation

enum APIError: Error {
    case unexpectedError(error: String)
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .unexpectedError(let error):
            return NSLocalizedString("Received unexpected error. \(error)", comment: "")
        }
    }
}
