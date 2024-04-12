//
//  VoterCandidatesService.swift
//  Your Ballot
//
//  Created by Peter Herman on 4/12/24.
//

import Foundation

@MainActor
class VoterCandidatesService: ObservableObject {
    private let provider: any HTTPProvider
    private let decoder: JSONDecoder = JSONDecoder()
    
    @Published var candidates: [Candidate]
    
    init(provider: any HTTPProvider = URLSession.shared) {
        self.provider = provider
        self.candidates = []
    }
    
    /*
     * Initializer/constructor useful for previews
     */
    init(candidates: [Candidate], provider: any HTTPProvider = URLSession.shared) {
        self.candidates = candidates
        self.provider = provider
    }
    
    /*
     * Fetch voter candidates from the API, serialize the results into [Candidate]
     * which is saved as a @Published var candidates on this class
     */
    func fetchCandidates() async throws {
        let task = Task<[Candidate], Error> {
            let candidateData = try await provider.getHttp(from: URL(string:"\(API_BASE)/v1/voter/candidate/")!)
            let voterCandidatesSerializer = try decoder.decode(VoterCandidatesSerializer.self, from: candidateData)
            return voterCandidatesSerializer.candidates
        }
        let fetchedCandidates = try await task.value
        self.candidates = fetchedCandidates
    }
}
