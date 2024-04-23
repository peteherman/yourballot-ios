//
//  IssueRankRegion.swift
//  Your Ballot
//
//  Created by Peter Herman on 4/23/24.
//

import SwiftUI

struct IssueRankRegion: View {
    @Binding var issues: [IssueBubble]
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .frame(maxWidth: .infinity)
                .foregroundColor(Theme.light_blue.mainColor)
            VStack {
                ForEach(issues, id: \.id) { issue_bubble in
                    Text("Issue: \(issue_bubble.issue)")
                        .draggable(issue_bubble.issue)
                }
            }
        }
    }
}

#Preview {
    IssueRankRegion(issues: .constant([]))
}
