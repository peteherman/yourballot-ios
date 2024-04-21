//
//  MockGuestQuestionProvider.swift
//  Your BallotTests
//
//  Created by Peter Herman on 4/16/24.
//

import Foundation

class MockGuestQuestionProvider: HTTPProvider {
    func getHttp(from url: URL) async throws -> Data {
        try await Task.sleep(nanoseconds: UInt64.random(in: 100_000_000...500_000_000))
        let urlPath = url.path()
        switch url.pathExtension {
        case _ where urlPath.contains("/candidate/matches"):
            return testVoterCandidatesData
        default:
            print("\(urlPath) didn't match any cases")
            return allQuestions
        }
    }
    func postHttp(data message: Codable, to url: URL) async throws -> Data {
        try await Task.sleep(nanoseconds: UInt64.random(in: 100_000_000...500_000_000))
        let urlPath = url.path()
        switch url.pathExtension {
        case _ where urlPath.contains("/guest/candidates"):
            return testVoterCandidatesData
        default:
            print("\(urlPath) didn't match any cases")
            return allQuestions
        }
    }
}

