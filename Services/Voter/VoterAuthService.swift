//
//  VoterAuthService.swift
//  Your Ballot
//
//  Created by Peter Herman on 5/24/24.
//

import Foundation
import OSLog

class VoterAuthService: BaseService {
    private let provider: any HTTPProvider
    private let decoder: JSONDecoder = JSONDecoder()
    private let loginURL: URL = URL(string: "\(API_BASE)/v1/voter/login/")!
    private let tokenRefreshURL: URL = URL(string: "\(API_BASE)/api/token/refresh/")!
    private let registerURL: URL = URL(string: "\(API_BASE)/v1/voter/register/")!
    private var logger = Logger()
    
    init(provider: any HTTPProvider = URLSession.shared) {
        self.provider = provider
    }
    
    /*
     * Will atttempt to authenticate the user to the API using @param email and @param password
     * Returns a tuple containing:
     * AuthTokens and an empty string if the request was successful
     * nil and an error message to be displayed if the request was not successful
     */
    func login(email: String, password: String) async throws -> (AuthTokens?, String) {
        let requestBody = VoterLoginRequestBody(email: email, password: password)
        logger.debug("Making login request to API")
        let task = Task<(AuthTokens?, String), Error> {
            
            let (responseData, httpResponse) = try await provider.postHttpResponse(data: requestBody, to: loginURL)
            if self.requestSuccessful(httpResponse) {
                let authTokens = try self.serializeAuthTokensFromLoginResponseData(data: responseData)
                return (authTokens, "")
            }
            
            let errorMessage = try self.parseErrorMessageFromResponseData(responseData)
            return (nil, errorMessage)
        }
        var (authTokens, errorMessage) = try await task.value
        
        if let authTokens {
            logger.debug("Successfully authenticated to the API. Returning auth tokens")
        } else {
            logger.debug("Failed to authenticate to the API: \(errorMessage)")
        }
        
        if authTokens == nil && errorMessage == "" {
            errorMessage = "Login attempt failed"
        }
        
        return (authTokens, errorMessage)
    }
    
    func serializeAuthTokensFromLoginResponseData(data: Data) throws -> AuthTokens {
        let authTokenSerializer = try decoder.decode(AuthResponseSerializer.self, from: data)
        return authTokenSerializer.authTokens!
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
    
    func register(registerBody: VoterRegistrationRequestBody) async throws -> AuthTokens {
        logger.debug("Making registration request to API")
        let task = Task<AuthTokens, Error> {
            let tokenData = try await provider.postHttp(data: registerBody, to: registerURL)
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
    
}
