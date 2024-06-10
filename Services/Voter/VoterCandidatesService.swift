//
//  VoterCandidatesService.swift
//  Your Ballot
//
//  Created by Peter Herman on 4/12/24.
//

import Foundation
import OSLog

@MainActor
class VoterCandidatesService: ObservableObject {
    private let provider: any HTTPProvider
    private let decoder: JSONDecoder = JSONDecoder()
    private let logger: Logger = Logger()
    private let voterAuthService: VoterAuthService
    
    @Published var candidates: [Candidate]
    
    init(provider: any HTTPProvider = URLSession.shared, voterAuthService: VoterAuthService? = nil) {
        self.provider = provider
        self.candidates = []
        if voterAuthService != nil {
            self.voterAuthService = voterAuthService!
        } else {
            self.voterAuthService = VoterAuthService(provider: self.provider)
        }
    }
    
    /*
     * Initializer/constructor useful for previews
     */
    init(candidates: [Candidate], provider: any HTTPProvider = URLSession.shared, voterAuthService: VoterAuthService? = nil) {
        self.candidates = candidates
        self.provider = provider
        if voterAuthService != nil {
            self.voterAuthService = voterAuthService!
        } else {
            self.voterAuthService = VoterAuthService(provider: self.provider)
        }
    }
    
    /*
     * Fetch voter candidates from the API, serialize the results into [Candidate]
     * which is saved as a @Published var candidates on this class
     */
    func fetchCandidates() async throws {
        logger.debug("Fetching candidates")        
        let task = Task<[Candidate], Error> {
            let authTokens = try await self.voterAuthService.getTokensForAuthenticatedRequest()
            let candidateData = try await provider.authenticatedGetHttp(from: URL(string:"\(API_BASE)/v1/voter/candidate/")!, accessToken: authTokens.access)
            let voterCandidatesSerializer = try decoder.decode(VoterCandidatesSerializer.self, from: candidateData)
            return voterCandidatesSerializer.candidates
        }
        let fetchedCandidates = try await task.value
        logger.debug("Received candidates: \(fetchedCandidates)")
        self.candidates = fetchedCandidates
    }
    
    /*
     * Groups the candidates within .candidates by political locality type
     * @returns a dictionary which maps politicallocalitytype to an array of candidates
     */
    func groupCandidatesByLocalityType() -> Dictionary<PoliticalLocalityType,[Candidate]> {
        var candidateLocalityMap: Dictionary<PoliticalLocalityType,[Candidate]> = [:]
        for candidate in self.candidates {
            guard candidate.position != nil else { continue }
            let candidatePosition = candidate.position!
            if candidateLocalityMap.keys.contains(candidatePosition.locality.type) {
                candidateLocalityMap[candidatePosition.locality.type]?.append(candidate)
            } else {
                candidateLocalityMap[candidatePosition.locality.type] = [ candidate ]
            }
        }
        return candidateLocalityMap
    }
}
