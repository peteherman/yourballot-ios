//
//  MockSingleCandidateProvider.swift
//  Your BallotTests
//
//  Created by Peter Herman on 4/9/24.
//

import Foundation

class MockSingleCandidateProvider: HTTPProvider {
    func getHttp(from url: URL) async throws -> Data {
        try await Task.sleep(nanoseconds: UInt64.random(in: 100_000_000...500_000_000))
        return testCandidateDetail
    }
    func postHttp(data message: Encodable, to url: URL) async throws -> Data {
        try await Task.sleep(nanoseconds: UInt64.random(in: 100_000_000...500_000_000))
        return "test".data(using: .utf8)!
    }
    func postHttpResponse(data message: any Encodable, to url: URL) async throws -> (Data, HTTPURLResponse) {
        throw APIError.unexpectedError(error: "Not Implemented")
    }
    func authenticatedGetHttp(from url: URL, accessToken: String) async throws -> Data {
        throw APIError.unexpectedError(error: "Not Implemented")
    }
}
