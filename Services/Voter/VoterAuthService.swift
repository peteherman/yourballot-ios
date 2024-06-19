//
//  VoterAuthService.swift
//  Your Ballot
//
//  Created by Peter Herman on 5/24/24.
//

import Foundation
import OSLog

class VoterAuthService: BaseService, ObservableObject {
    private let authTimeoutMin: Int = 3600
    private let provider: any HTTPProvider
    private let decoder: JSONDecoder = JSONDecoder()
    private let loginURL: URL = URL(string: "\(API_BASE)/v1/voter/login/")!
    private let tokenRefreshURL: URL = URL(string: "\(API_BASE)/api/token/refresh/")!
    private let registerURL: URL = URL(string: "\(API_BASE)/v1/voter/register/")!
    private var logger = Logger()
    private var authTokens: AuthTokens? = nil

    /*
     * Computed property. Returns true if the Voter is Authenticated, False otherwise
     */
    public var isAuthenticated: Bool {
        // Check if tokens already exist on this service
        if authTokens != nil {
            logger.debug("Tokens existed within service already")
            return true
        }
        // Check if tokens exist in storage, if so, recreate them from their stored state and set
        // the createdAt time to a time that's already expired so they'll get refreshed on the next attempt
        logger.debug("Attempting to access tokens within storage")
        let tokenStorage = TokenStorage()
        let refreshToken = tokenStorage.getRefreshToken()
        if let refreshToken {
            let accessToken = tokenStorage.getRefreshToken()
            if let accessToken {
                logger.debug("Found tokens within storage. Recreating auth tokens with already expired 'createdAt'")
                let createdAtAlreadyExpired = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
                let authTokensFromStorage = AuthTokens(access: accessToken, refresh: refreshToken, createdAt: createdAtAlreadyExpired)
                self.authTokens = authTokensFromStorage
                return true
            }
        }
        logger.debug("Tokens not found on service and not found in storage. Voter is not authenticated")
        return false
    }
    
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
                self.saveTokens(authTokens)
                return (authTokens, "")
            }
            
            let errorMessage = try self.parseErrorMessageFromResponseData(responseData)
            return (nil, errorMessage)
        }
        var (authTokens, errorMessage) = try await task.value
        
        if let authTokens {
            self.authTokens = authTokens
            logger.debug("Successfully authenticated to the API. Returning auth tokens")
        } else {
            self.authTokens = nil
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
            self.saveTokens(authTokens)
            return authTokens
        }
        let authTokens = try await task.value
        logger.debug("Successfully refreshed tokens. Returning auth tokens")
        return authTokens
    }
    
    func register(registerBody: VoterRegistrationRequestBody) async throws -> (AuthTokens?, String) {
        logger.debug("Making registration request to API")
        logger.debug("Race: \(registerBody.race.string())")
        logger.debug("Gender: \(registerBody.gender.string())")
        let task = Task<(AuthTokens?, String), Error> {
            let (responseData, httpResponse) = try await provider.postHttpResponse(data: registerBody, to: registerURL)
            if self.requestSuccessful(httpResponse) {
                let authTokens = try self.serializeAuthTokensFromLoginResponseData(data: responseData)
                self.saveTokens(authTokens)
                return (authTokens, "")
            }
            let errorMessage = try self.parseErrorMessageFromResponseData(responseData)
            return (nil, errorMessage)
        }
        var (authTokens, errorMessage) = try await task.value
        if let authTokens {
            self.authTokens = authTokens
            logger.debug("Successfully registered and authenticated to the API. Returning auth tokens")
        } else {
            self.authTokens = nil
            logger.debug("Failed to authenticate to the API: \(errorMessage)")
        }
        if authTokens == nil && errorMessage == "" {
            errorMessage = "Registration attempt failed. Please try again later"
        }
        return (authTokens, errorMessage)
    }
    
    /*
     * Called by other providers when working under the assumption that the
     * Voter is already authenticated. Will raise an exception in the event the
     * Voter is not Authenticated
     * Will make a request to refresh authentication tokens if the auth tokens are believed
     * to be expired
     */
    func getTokensForAuthenticatedRequest() async throws -> AuthTokens {
        
        if self.authTokens == nil {
            let isAuth = try await self.isAuthenticatedTryTokens()
            if !isAuth {
                throw APIError.unexpectedError(error: "Unable to gather auth tokens")
            }
        }
        let currentTokens = self.authTokens!
        
        if currentTokens.expired {
            logger.info("Detected expired tokens. Refreshing tokens now")
            let newTokens = try await self.refreshTokens(tokens: currentTokens)
            self.authTokens = newTokens
            self.saveTokens(newTokens)
            return newTokens
        }
        
        return currentTokens
    }
    
    func saveTokens(_ tokens: AuthTokens) -> Void {
        let tokenStorage = TokenStorage()
        tokenStorage.saveTokens(authTokens: tokens)
    }
    
    func clearTokens() -> Void {
        let tokenStorage = TokenStorage()
        tokenStorage.clearTokens()
    }
    
    /*
     * Really only executed upon startup-up of app
     * Will return false if self.authTokens don't exist
     * If tokens exist, will attempt to refresh them
     * if refresh successful, then will returns true
     * otherwise returns false
     */
    func isAuthenticatedTryTokens() async throws -> Bool {
        if self.isAuthenticated {
            do {
                logger.info("Auth tokens exist, attempting to get tokens for next API request")
                _ = try await self.getTokensForAuthenticatedRequest()
                logger.info("Tokens are not expired. Returning true")
                return true
            } catch {
                logger.info("Exception occurred when attempting to fetch tokens for the next API request: \(error.localizedDescription)")
                self.clearTokens()
                return false
            }
        }
        return false
    }
    
}
