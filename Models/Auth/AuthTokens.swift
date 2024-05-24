//
//  AuthTokens.swift
//  Your Ballot
//
//  Created by Peter Herman on 5/24/24.
//

import Foundation

struct AuthTokens {
    let access: String
    let refresh: String
    let createdAt: Date
}

struct AuthTokenResponse: Decodable {
    let access: String
    let refresh: String
}
