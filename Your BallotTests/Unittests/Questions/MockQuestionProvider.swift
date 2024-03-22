//
//  MockQuestionProvider.swift
//  Your BallotTests
//
//  Created by Peter Herman on 3/19/24.
//

import Foundation

class MockQuestionProvider: HTTPProvider {
    func getHttp(from url: URL) async throws -> Data {
        try await Task.sleep(nanoseconds: UInt64.random(in: 100_000_000...500_000_000))
        return testVoterRemainingQuestionsData
    }
    func postHttp(data message: Codable, to url: URL) async throws -> Data {
        try await Task.sleep(nanoseconds: UInt64.random(in: 100_000_000...500_000_000))
        return "test".data(using: .utf8)!
    }
}
