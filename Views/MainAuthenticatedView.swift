//
//  MainAuthenticatedView.swift
//  Your Ballot
//
//  Created by Peter Herman on 4/22/24.
//

import SwiftUI

struct MainAuthenticatedView: View {
    
    let maxValue: Double = 10.0
    private var value: Double = 5.0
    private var questionProvider: any HTTPProvider = MockQuestionProvider()
    
    @State private var selection = 1
    
    var body: some View {
        TabView(selection: $selection) {
            NavigationView {
                HomeQuestionView(responseValue: 5.0, maxResponseValue: maxValue, questionService: QuestionService(provider: insecure_provider()))
            }
            .tabItem {
                Label("Questions", systemImage: "questionmark.circle")
            }
            .tag(0)
            
            NavigationView {
                HomeVoterCandidatesView(candidateService: VoterCandidatesService(provider: insecure_provider()))
            }
            .tabItem {
                Label("Home", systemImage: "house")
            }
            .tag(1)
            NavigationView {
                HomeProfileView()
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
