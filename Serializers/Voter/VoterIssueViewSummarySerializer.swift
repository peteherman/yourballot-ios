//
//  VoterIssueViewSummarySerializer.swift
//  Your Ballot
//
//  Created by Peter Herman on 4/11/24.
//

import Foundation

class VoterIssueViewSummarySerializer: BaseSerializer {
    var issueViews: IssueViewsSummary = [:]
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
        let _ = try rootContainer.nestedContainer(keyedBy: PaginationCodingKeys.self, forKey: RootCodingKeys.result_info)
        let decodedIssueViewsSummary = try rootContainer.decode(VoterIssueViews.self, forKey: RootCodingKeys.result)
        issueViews = decodedIssueViewsSummary.issue_views
    }
    
}
