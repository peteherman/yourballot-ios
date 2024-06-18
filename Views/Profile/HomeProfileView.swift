//
//  HomeProfileView.swift
//  Your Ballot
//
//  Created by Peter Herman on 4/22/24.
//

import SwiftUI

struct HomeProfileView: View {
    let voter: Voter
    var body: some View {
        ScrollView {
            VStack {
                NavigationLink(destination: ProfileSettings()) {
                    HStack {
                        Text("Profile")
                            .font(.title2)
                        Image(systemName: "gearshape")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.bottom], 10)
                }
                Text("Political Profile")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.bottom], 5)
                PoliticalProfileHeaderView(voter: voter)
                    .padding([.bottom], 20)
                HStack {
                    Text("Issues")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Prior Responses")
                }
                .padding([.bottom], 10)
                NavigationLink(destination: IssueRankingView()) {
                    Text("Change what matters most to you")
                }
                if (voter.issue_views == nil) {
                    Text("Answer some questions so you can view your Political Profile!")
                        .multilineTextAlignment(.center)
                        .padding([.top], 30)
                } else {
                    let issue_views = voter.issue_views ?? [:]
                    VStack {
                        ForEach(Array(issue_views.keys), id: \.self) {
                            issue_name in
                            let voterRating = issue_views[issue_name] ?? 0.0
                            VoterIssueSlider(issueName: issue_name, voterRating: voterRating)
                                .cornerRadius(7.0)
                                .padding([.leading, .trailing])
                        }
                    }
                    .padding([.bottom])
                }
            }
            .padding([.leading, .trailing], 20)

        }
    }
}

#Preview {
    HomeProfileView(voter: Voter.sampleData[0])
}
