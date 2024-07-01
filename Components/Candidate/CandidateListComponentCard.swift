//
//  CandidateListComponentCard.swift
//  Your Ballot
//
//  Created by Peter Herman on 4/13/24.
//

import SwiftUI

struct CandidateListComponentCard: View {
    let candidate: Candidate
    var body: some View {
        NavigationLink(destination: CandidateView(candidate: candidate, candidateService: SingleCandidateService(provider: insecure_provider()), voterIssueViewService: VoterIssueViewService(provider: insecure_provider()))) {
            HStack(spacing: 0) {
                Image("BidenImage")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 75, height: 75)
                    .clipped()
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .frame(alignment: .leading)
                    .padding([.leading, .top, .bottom], 5)
                    .padding([.trailing], 20)
                VStack {
                    Text("\(candidate.name)")
                    Text("\(candidate.position?.title ?? "Candidate" )")
                        .font(.caption)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                VStack {
                    if candidate.similarityPercentage != nil {
                        Text("\(candidate.similarityPercentage!)%")
                        Text("match")
                            .font(.caption)
                    } else {
                        Text("")
                    }
                }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .trailing)
                .padding([.trailing], 20.0)
            }
            .frame(maxWidth: .infinity)
            .background(Theme.light_blue.mainColor)
            .cornerRadius(10.0)
            .padding([.top, .leading, .trailing])
            .padding([.bottom], 3.0)
        }
    }
}
    
#Preview {
    CandidateListComponentCard(candidate: Candidate.sampleData[0])
}
