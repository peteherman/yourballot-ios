//
//  VoterIssueViewService.swift
//  Your Ballot
//
//  Created by Peter Herman on 4/11/24.
//

import Foundation

@MainActor
class VoterIssueViewService: ObservableObject {
    private let provider: any HTTPProvider
    private let decoder: JSONDecoder = JSONDecoder()
    
    @Published var issue_views: IssueViewsSummary?
    
    init(provider: any HTTPProvider = URLSession.shared) {
        self.provider = provider
    }
    
    /*
     * Initializer/constructor useful for previews
     */
    init(issue_views: IssueViewsSummary, provider: any HTTPProvider = URLSession.shared) {
        self.issue_views = issue_views
        self.provider = provider
    }
    
    /*
     * Fetch Issue View Summary from the API, serialize the results into IssueViewsSummary (a dictionary)
     * which is saved as a @Published var issue_views on this class
     */
    func fetchVoterIssueViews() async throws {
        let task = Task<IssueViewsSummary, Error> {
            let issueViewData = try await provider.getHttp(from: URL(string:"\(API_BASE)/v1/voter/opinions/summary")!)
            let issueViewSerializer = try decoder.decode(VoterIssueViewSummarySerializer.self, from: issueViewData)
            return issueViewSerializer.issueViews
        }
        let fetchedIssueViews = try await task.value
        self.issue_views = fetchedIssueViews
    }
}
