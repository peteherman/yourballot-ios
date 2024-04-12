//
//  MockVoterCandidatesProvider.swift
//  Your Ballot
//
//  Created by Peter Herman on 4/12/24.
//

import Foundation

class MockVoterCandidatesProvider: HTTPProvider {
    func getHttp(from url: URL) async throws -> Data {
        try await Task.sleep(nanoseconds: UInt64.random(in: 100_000_000...500_000_000))
        return testVoterCandidatesData
    }
    func postHttp(data message: Codable, to url: URL) async throws -> Data {
        try await Task.sleep(nanoseconds: UInt64.random(in: 100_000_000...500_000_000))
        return "test".data(using: .utf8)!
    }
}


