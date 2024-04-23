//
//  MainAuthenticatedView.swift
//  Your Ballot
//
//  Created by Peter Herman on 4/22/24.
//

import SwiftUI

struct MainAuthenticatedView: View {
    private var voterCandidateProvider = MockVoterCandidatesProvider()
    private var sampleCandidates = Candidate.sampleData
    
    let maxValue: Double = 10.0
    private var value: Double = 5.0
    private var questionProvider: any HTTPProvider = MockQuestionProvider()
    
    @State private var selection = 2
    
    var body: some View {
        TabView(selection: $selection) {
            NavigationView {
                HomeQuestionView(responseValue: 5.0, maxResponseValue: maxValue, questionService: QuestionService(provider: questionProvider))
            }
            .tabItem {
                Label("Questions", systemImage: "questionmark.circle")
            }
            .tag(0)
            
            NavigationView {
                HomeVoterCandidatesView(candidateService: VoterCandidatesService(candidates: sampleCandidates, provider: voterCandidateProvider))
            }
            .tabItem {
                Label("Home", systemImage: "house")
            }
            .tag(1)
            NavigationView {
                HomeProfileView(voter: Voter.sampleData[0])
            }
            .tabItem {
                Label("Profile", systemImage: "person.crop.circle")
            }
            .tag(2)
        }
    }
}

#Preview {
    MainAuthenticatedView()
}
