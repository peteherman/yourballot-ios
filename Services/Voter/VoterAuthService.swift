//
//  VoterAuthService.swift
//  Your Ballot
//
//  Created by Peter Herman on 5/24/24.
//

import Foundation
import OSLog

class VoterAuthService {
    private let provider: any HTTPProvider
    private let decoder: JSONDecoder = JSONDecoder()
    private let loginURL: URL = URL(string: "\(API_BASE)/v1/voter/login/")!
    private let tokenRefreshURL: URL = URL(string: "\(API_BASE)/api/token/refresh/")!
    private var logger = Logger()
    
    init(provider: any HTTPProvider = URLSession.shared) {
        self.provider = provider
    }
    
    func login(email: String, password: String) async throws -> AuthTokens {
        let requestBody = VoterLoginRequestBody(email: email, password: password)
        logger.debug("Making login request to API")
        let task = Task<AuthTokens, Error> {
            let tokenData = try await provider.postHttp(data: requestBody, to: loginURL)
            let authTokenSerializer = try decoder.decode(AuthResponseSerializer.self, from: tokenData)
            if authTokenSerializer.authTokens != nil {
                return authTokenSerializer.authTokens!
            }
            throw APIError.unexpectedError(error: "Auth token serializer was unable to decode the response from the API")
        }
        let authTokens = try await task.value
        logger.debug("Successfully authenticated to the API. Returning auth tokens")
        return authTokens
    }
    
    func refreshTokens(tokens: AuthTokens) async throws -> AuthTokens {
        logger.debug("Making token refresh request to API")
        let task = Task<AuthTokens, Error> {
            let tokenData = try await provider.postHttp(data: tokens, to: tokenRefreshURL)
            let authTokenSerializer = try decoder.decode(RefreshTokenResponse.self, from: tokenData)
            let authTokens = AuthTokens(access: authTokenSerializer.access, refresh: tokens.refresh, createdAt: Date())
            return authTokens
        }
        let authTokens = try await task.value
        logger.debug("Successfully refreshed tokens. Returning auth tokens")
        return authTokens
    }
    
}
