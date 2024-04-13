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
