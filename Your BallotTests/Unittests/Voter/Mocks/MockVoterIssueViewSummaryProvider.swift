//
//  MockVoterIssueViewSummaryProvider.swift
//  Your BallotTests
//
//  Created by Peter Herman on 4/11/24.
//

import Foundation

class MockVoterIssueViewSummaryProvider: HTTPProvider {
    func getHttp(from url: URL) async throws -> Data {
        try await Task.sleep(nanoseconds: UInt64.random(in: 100_000_000...500_000_000))
        return testVoterIssueViewsSummaryData
    }
    func postHttp(data message: Encodable, to url: URL) async throws -> Data {
        try await Task.sleep(nanoseconds: UInt64.random(in: 100_000_000...500_000_000))
        return "test".data(using: .utf8)!
    }
}

