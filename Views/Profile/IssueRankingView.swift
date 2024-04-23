//
//  IssueRankingView.swift
//  Your Ballot
//
//  Created by Peter Herman on 4/23/24.
//

import SwiftUI

struct IssueBubble {
    var id = UUID()
    var color: Color
    var issue: String
}

struct IssueRankingView: View {
    let regions: Int = 5
    @State private var rankOne: [IssueBubble] = [IssueBubble(color: .white, issue: "Hi")]
    @State private var rankTwo: [IssueBubble] = []
    @State private var rankThree: [IssueBubble] = []
    @State private var rankFour: [IssueBubble] = []
    @State private var rankFive: [IssueBubble] = []
    
    var body: some View {
        VStack {
            IssueRankRegion(issues: $rankOne)
                
            IssueRankRegion(issues: $rankTwo)
                .dropDestination(for: String.self) { droppedIssues, location in
                    // Do external api updates
                    for issue in droppedIssues {
                        rankOne.removeAll { $0.issue == issue }
                        rankTwo.append(IssueBubble(color: .black, issue: issue))
                    }
                    return true
                }
            IssueRankRegion(issues: $rankThree)
            IssueRankRegion(issues: $rankFour)
            IssueRankRegion(issues: $rankFive)
        }
        .padding([.leading, .trailing])
    }
}

#Preview {
    IssueRankingView()
}
