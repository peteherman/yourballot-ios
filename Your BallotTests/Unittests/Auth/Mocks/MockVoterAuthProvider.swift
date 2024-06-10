//
//  MockVoterAuthProvider.swift
//  Your BallotTests
//
//  Created by Peter Herman on 5/30/24.
//

import Foundation

class MockVoterAuthProviderSuccess: HTTPProvider {
    func getHttp(from url: URL) async throws -> Data {
        throw APIError.unexpectedError(error: "Not implemented")
    }
    func postHttp(data message: Encodable, to url: URL) async throws -> Data {
        try await Task.sleep(nanoseconds: UInt64.random(in: 100_000_000...500_000_000))
        let urlPath = url.path()
        switch url.pathExtension {
        case _ where urlPath.contains("/voter/login"):
            return testVoterCandidatesData
        default:
            print("\(urlPath) didn't match any cases")
            return allQuestions
        }
    }
    
    func postHttpResponse(data message: any Encodable, to url: URL) async throws -> (Data, HTTPURLResponse) {
        try await Task.sleep(nanoseconds: UInt64.random(in: 100_000_000...500_000_000))
        let httpResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
        return (testVoterLoginResponse, httpResponse)
    }
    func authenticatedGetHttp(from url: URL, accessToken: String) async throws -> Data {
        throw APIError.unexpectedError(error: "Not Implemented")
    }
}
