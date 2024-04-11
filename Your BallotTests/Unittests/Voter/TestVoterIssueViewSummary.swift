//
//  TestVoterIssueViewSummary.swift
//  Your BallotTests
//
//  Created by Peter Herman on 4/11/24.
//

import XCTest
@testable import Your_Ballot

final class TestVoterIssueViewSummary: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDeserializeVoterIssueViewSummary() throws {
        let rawResponse = testVoterIssueViewsSummaryData
        let decoder = JSONDecoder()
        let issueViewSerializer = try decoder.decode(VoterIssueViewSummarySerializer.self, from: rawResponse)
        let issueViews = issueViewSerializer.issueViews
        XCTAssertGreaterThan(issueViews.keys.count, 0)
    }
    
    func testFetchVoterIssueViews() async throws {
        let provider = MockVoterIssueViewSummaryProvider()
        let voterIssueViewService = await VoterIssueViewService(provider: provider)
        let _: @MainActor () async throws -> Void = {
            try await voterIssueViewService.fetchVoterIssueViews()
            XCTAssertNotNil(voterIssueViewService.issue_views)
            let issue_views = voterIssueViewService.issue_views!
            XCTAssertGreaterThan(issue_views.keys.count, 0)
        }
    }
}
