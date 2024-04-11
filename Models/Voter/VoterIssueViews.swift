//
//  VoterIssueViews.swift
//  Your Ballot
//
//  Created by Peter Herman on 4/11/24.
//

import Foundation

struct VoterIssueViews: Decodable {
    let issue_views: IssueViewsSummary
}

extension VoterIssueViews {
    static let sampleData: [IssueViewsSummary] = [
        [ "Healthcare": 3.0,
          "Abortion": 7.5,
          "Gun Control": -3.0,
          "Environment": 2.0,
          "Immigration": -3.0
        ]
    ]
}
