//
//  GuestMatchesView.swift
//  Your Ballot
//
//  Created by Peter Herman on 4/14/24.
//

import SwiftUI

struct GuestMatchesView: View {
    let guestQuestionService: GuestQuestionService
    let guestTrial: GuestTrial
    
    @ViewBuilder
    var body: some View {
        if guestQuestionService.candidateMatches.count > 0 {
            let candidateLocalityMap = guestQuestionService.groupCandidatesByLocalityType()
            VStack {
                ScrollView {
                    Text("Your Matches")
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
                HStack {
                    Button("Sign-Up", action: {})
                    Button("Restart", action: {})
                }
            }
        } else {
            Text("Loading Candidate Matches")
        }
    }
}

struct GuestMatches_Preview: PreviewProvider {
    static var mockGuestQuestionProvider = MockGuestQuestionProvider()
    static var guestQuestionService = GuestQuestionService(provider: mockGuestQuestionProvider, candidateMatches: Candidate.sampleData)
    static var guestTrial = GuestTrial()
    static var previews: some View {
        GuestMatchesView(guestQuestionService: guestQuestionService, guestTrial: guestTrial)
    }
}
