//
//  TestVoterIssueViewSummaryData.swift
//  Your BallotTests
//
//  Created by Peter Herman on 4/11/24.
//

import Foundation

let testVoterIssueViewsSummaryData = """
{
    "result_info": {
        "next": null,
        "previous": null,
        "total": 0
    },
    "result": {
        "issue_views": {
            "Healthcare": 3.0,
            "Abortion": 0.0,
            "Gun Control": 0.0,
            "Environment": 0.0,
            "Immigration": 0.0
        }
    }
}
""".data(using: .utf8)!
