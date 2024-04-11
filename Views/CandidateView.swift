//
//  CandidateView.swift
//  Your Ballot
//
//  Created by Peter Herman on 4/2/24.
//

import SwiftUI

struct CandidateView: View {
    @StateObject var candidateService: SingleCandidateService
    @ViewBuilder
    var body: some View {
        if candidateService.candidate != nil {
            let candidate = candidateService.candidate!
            ScrollView {
                VStack {
                    CandidateCard(candidate: Candidate.sampleData[0])
                        .padding(.bottom)
                    VStack {
                        Text("Political Profile")
                            .font(.title3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding([.leading, .bottom])
                        PoliticalProfileLabelCard(label: "Position", value: candidate.position?.title ?? "")
                        PoliticalProfileLabelCard(label: "Position", value: candidate.position?.locality.name ?? "")
                        PoliticalProfileLabelCard(label: "Self-Identity", value: candidate.political_party.string())
                    }
                    .padding(.bottom)
                    VStack {
                        Text("Issues")
                            .font(.title3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding([.leading, .bottom])
                        ForEach(Array(candidate.issue_views.keys), id: \.self) { issue_name in
                            PoliticalIssueSlider(issueName: issue_name, candidateRating: candidate.issue_views[issue_name]!, voterRating: 3.0)
                                .cornerRadius(7.0)
                                .padding([.leading, .trailing])
                        }
                    }
                }
            }
        } else {
            Text("Candidate loading...")
        }
    }
}

struct CandidateView_Preview: PreviewProvider {
    static var candidateProvider: any HTTPProvider = MockSingleCandidateProvider()
    static var sampleCandidate = Candidate.sampleData[0]
    static var singleCandidateService = SingleCandidateService(candidate: sampleCandidate)

    static var previews: some View {
        CandidateView(candidateService: singleCandidateService)
    }
}
