//
//  CandidateView.swift
//  Your Ballot
//
//  Created by Peter Herman on 4/2/24.
//

import SwiftUI

struct CandidateView: View {
    var body: some View {
        ScrollView {
            VStack {
                CandidateCard(candidate: Candidate.sampleData[0])
                    .padding(.bottom)
                VStack {
                    Text("Political Profile")
                        .font(.title3)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding([.leading, .bottom])
                    PoliticalProfileLabelCard(label: "Position", value: "President")
                    PoliticalProfileLabelCard(label: "Locality", value: "United States")
                    PoliticalProfileLabelCard(label: "Years of Service", value: "2.2")
                    PoliticalProfileLabelCard(label: "Self-Identity", value: "Democrat")
                    PoliticalProfileLabelCard(label: "Ballot Identity", value: "Democrat")
                }
                .padding(.bottom)
                VStack {
                    Text("Issues")
                        .font(.title3)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding([.leading, .bottom])
                    PoliticalIssueSlider(candidateRatingPercentage: 0.5, voterRatingPercentage: 0.7)
                        .padding([.leading, .trailing])
                }
            }
        }
    }
}

#Preview {
    CandidateView()
}
