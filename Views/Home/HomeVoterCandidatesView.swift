//
//  HomeVoterCandidatesView.swift
//  Your Ballot
//
//  Created by Peter Herman on 4/22/24.
//

import SwiftUI
import OSLog

struct HomeVoterCandidatesView: View {
    let candidateService: VoterCandidatesService
    let voterAuthService: VoterAuthService
    let logger: Logger = Logger()
    
    init(candidateService: VoterCandidatesService, voterAuthService: VoterAuthService? = nil) {
        self.candidateService = candidateService
        if voterAuthService != nil {
            self.voterAuthService = voterAuthService!
        } else {
            let provider = URLSession(configuration: .default, delegate: CustomSessionDelegate(), delegateQueue: nil)
            self.voterAuthService = VoterAuthService(provider: provider)
        }
    }
    
    @ViewBuilder
    var body: some View {
        NavigationView {
            if candidateService.candidates.count > 0 {
                let candidateLocalityMap = candidateService.groupCandidatesByLocalityType()
                ScrollView {
                    Text("My Representatives")
                        .font(.title2)
                        .foregroundStyle(Theme.deep_blue.mainColor)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding([.leading], 20)
                        .padding([.bottom])
                    ForEach(Array(candidateLocalityMap.keys), id: \.self) { localityType in
                        VStack(spacing: 5) {
                            Text("\(localityType.pretty)")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding([.leading, ], 20)
                            CandidateListComponent(candidates: candidateLocalityMap[localityType]!)
                        }
                    }
                }
            } else {
                Text("Loading Representatives")
                    .task {
                        try? await candidateService.fetchCandidates()
                    }
            }
        }
    }
}

struct HomeVoterCandidatesView_Preview: PreviewProvider {
    static var voterCandidateProvider = MockVoterCandidatesProvider()
    static var sampleCandidates = Candidate.sampleData
    static var voterCandidatesService = VoterCandidatesService(candidates: sampleCandidates, provider: voterCandidateProvider)

    static var previews: some View {
        HomeVoterCandidatesView(candidateService: voterCandidatesService)
    }
    
}
