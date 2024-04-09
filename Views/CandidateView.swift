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
            ScrollView {
                VStack {
                    CandidateCard(candidate: Candidate.sampleData[0])
                        .padding(.bottom)
                    VStack {
                        Text("Political Profile")
                            .font(.title3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding([.leading, .bottom])
                        PoliticalProfileLabelCard(label: "Position", value: candidateService.candidate?.position?.title ?? "")
                        PoliticalProfileLabelCard(label: "Position", value: "")
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
                            .cornerRadius(7.0)
                            .padding([.leading, .trailing])
                        
                    }
                }
            }
        } else {
            
        }
    }
}

struct CandidateView_Preview: PreviewProvider {
    static var candidateProvider: any HTTPProvider = MockSingleCandidateProvider()
    static var singleCandidateService = SingleCandidateService(provider: candidateProvider)
    
    static var previews: some View {
        CandidateView(candidateService: singleCandidateService)
    }
}
