//
//  CandidateVoterSliderComparison.swift
//  Your Ballot
//
//  Created by Peter Herman on 4/11/24.
//

import SwiftUI

struct CandidateVoterSliderComparison: View {
    @ObservedObject var candidateService: SingleCandidateService
    @ObservedObject var voterIssueViewService: VoterIssueViewService
    
    var body: some View {
        let candidate = candidateService.candidate!
        VStack {
            ForEach(Array(candidate.issue_views.keys), id: \.self) { 
                issue_name in
                let candidateRating = candidate.issue_views[issue_name]!
                let voterRating = voterIssueViewService.issue_views?[issue_name] ?? 0.0
                PoliticalIssueSlider(issueName: issue_name, candidateRating: candidateRating, voterRating: voterRating)
                    .cornerRadius(7.0)
                    .padding([.leading, .trailing])
            }
        }
    }
}

struct CandidateVoterSliderComparison_Preview: PreviewProvider {
    static var candidateProvider: any HTTPProvider = MockSingleCandidateProvider()
    static var sampleCandidate = Candidate.sampleData[0]
    static var singleCandidateService = SingleCandidateService(candidate: sampleCandidate)
    
    static var voterIssueViewProvider: any HTTPProvider = MockVoterIssueViewSummaryProvider()
    static var sampleVoterIssueViews = VoterIssueViews.sampleData[0]
    static var voterIssueViewService = VoterIssueViewService(issue_views: sampleVoterIssueViews)
    
    static var previews: some View {
        CandidateVoterSliderComparison(candidateService: singleCandidateService, voterIssueViewService: voterIssueViewService)
    }
}
