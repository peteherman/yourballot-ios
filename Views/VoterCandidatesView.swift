//
//  VoterCandidatesView.swift
//  Your Ballot
//
//  Created by Peter Herman on 4/12/24.
//

import SwiftUI

struct VoterCandidatesView: View {
    let candidateService: VoterCandidatesService
    
    
    @ViewBuilder
    var body: some View {
        if candidateService.candidates.count > 0 {
            let candidateLocalityMap = candidateService.groupCandidatesByLocalityType()
            VStack {
                Text("My Representatives")
                ForEach(Array(candidateLocalityMap.keys), id: \.self) { localityType in
                    VStack {
                        Text("\(localityType.pretty)")
                        CandidateListComponent(candidates: candidateLocalityMap[localityType]!)
                    }
                }
            }
        } else {
            Text("Loading Representatives")
        }
    }
}

struct VoterCandidatesView_Preview: PreviewProvider {
    static var voterCandidateProvider = MockVoterCandidatesProvider()
    static var sampleCandidates = Candidate.sampleData
    static var voterCandidatesService = VoterCandidatesService(candidates: sampleCandidates, provider: voterCandidateProvider)

    static var previews: some View {
        VoterCandidatesView(candidateService: voterCandidatesService)
    }
}
