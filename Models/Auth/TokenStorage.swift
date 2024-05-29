//
//  TokenStorage.swift
//  Your Ballot
//
//  Created by Peter Herman on 5/29/24.
//

import Foundation

class TokenStorage {
    private let accessTokenKey = "access_token"
    private let refreshTokenKey = "refresh_token"
    
    func saveTokens(authTokens: AuthTokens) -> Void {
        KeychainService.shared.save(accessTokenKey, value: authTokens.access)
        KeychainService.shared.save(refreshTokenKey, value: authTokens.refresh)
    }
    
    func getAccessToken() -> String? {
        return KeychainService.shared.get(accessTokenKey)
    }
    
    func getRefreshToken() -> String? {
        return KeychainService.shared.get(refreshTokenKey)
    }
    
    func updateAccessToken(accessToken: String) -> Void {
        KeychainService.shared.save(accessTokenKey, value: accessToken)
    }
}
