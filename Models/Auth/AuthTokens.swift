//
//  AuthTokens.swift
//  Your Ballot
//
//  Created by Peter Herman on 5/24/24.
//

import Foundation

struct AuthTokens: Encodable {
    let access: String
    let refresh: String
    let createdAt: Date
    
    let expirationMinutes: Int = 10 * 60
    
    var expired: Bool {
        let currentTime = Date()
        let expirationTime = Calendar.current.date(byAdding: .minute, value: expirationMinutes, to: currentTime)!
        return createdAt > expirationTime
    }
}

struct AuthTokenResponse: Decodable {
    let access: String
    let refresh: String
}

struct RefreshTokenResponse: Decodable {
    let access: String
}
