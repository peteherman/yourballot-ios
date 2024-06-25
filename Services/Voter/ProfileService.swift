//
//  ProfileService.swift
//  Your Ballot
//
//  Created by Peter Herman on 6/18/24.
//

import Foundation
import OSLog

class ProfileService: BaseService, ObservableObject {
    private let provider: any HTTPProvider
    private let logger: Logger = Logger()
    private let profileUrl: URL = URL(string: "\(API_BASE)/v1/voter/profile/")!
    private let decoder: JSONDecoder = JSONDecoder()
    private let voterAuthService: VoterAuthService
    
    @Published var voter: Voter?
    
    init(provider: any HTTPProvider = URLSession.shared, voterAuthService: VoterAuthService? = nil) {
        self.provider = provider
        if voterAuthService != nil {
            self.voterAuthService = voterAuthService!
        } else {
            self.voterAuthService = VoterAuthService(provider: insecure_provider())
        }
        self.voter = nil
    }
        
    func fetchProfile() async throws {
        logger.debug("Fetching voter profile")
        let task = Task<Voter, Error> {
            let authTokens = try await self.voterAuthService.getTokensForAuthenticatedRequest()
            let voterData = try await provider.authenticatedGetHttp(from: profileUrl, accessToken: authTokens.access)
            logger.debug("Attempting to deserialize voter profile")
            if let str = String(data: voterData, encoding: .utf8) {
                logger.debug("Successfully decoded: \(str)")
            }
            let voterProfileSerializer = try decoder.decode(VoterProfileSerializer.self, from: voterData)
            if voterProfileSerializer.voter != nil {
                logger.debug("Successfully received voter profile from the api")
                return voterProfileSerializer.voter
            }
            logger.debug("Received nil when attempting to deserialize voter profile response from the api")
            throw APIError.unexpectedError(error: "Unable to decode voter from response")
        }
        let voter = try await task.value
        self.voter = voter
    }
    
    
}

