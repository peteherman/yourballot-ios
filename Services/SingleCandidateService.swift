//
//  CandidateService.swift
//  Your Ballot
//
//  Created by Peter Herman on 4/9/24.
//

import Foundation

@MainActor
class SingleCandidateService: ObservableObject {
    private let provider: any HTTPProvider
    private let decoder: JSONDecoder = JSONDecoder()
    
    @Published var candidate: Candidate?
    
    init(provider: any HTTPProvider = URLSession.shared) {
        self.provider = provider
    }
    
    /*
     * Fetch a candidate's detailed view from the API, serialize the results into a candidate
     * struct which is saved as a @Published var candidate on this class
     */
    func fetchCandidate(candidateID: Int) async throws {
        let task = Task<Candidate, Error> {
            let candidateData = try await provider.getHttp(from: getCandidateURL(candidateID: candidateID))
            decoder.dateDecodingStrategy = .iso8601
            let candidateSerializer = try decoder.decode(CandidateAuthenticatedDetailedSerializer.self, from: candidateData)
            return candidateSerializer.candidate
        }
        let fetchedCandidate = try await task.value
        self.candidate = fetchedCandidate
    }
}

extension SingleCandidateService {
    func getCandidateURL(candidateID: Int) -> URL {
        return URL(string:"\(API_BASE)/v1/candidate/\(candidateID)/")!
    }
}
