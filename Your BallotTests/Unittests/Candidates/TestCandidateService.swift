//
//  Your_BallotTests.swift
//  Your BallotTests
//
//  Created by Peter Herman on 4/10/2024.
//

import XCTest
@testable import Your_Ballot

final class CandidateServiceTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testDeserializeCandidate() throws {
        let rawCandidateResponse = testCandidateDetail
        let decoder = JSONDecoder()
        let candidateSerializer = try decoder.decode(CandidateAuthenticatedDetailedSerializer.self, from: rawCandidateResponse)
        let candidate = candidateSerializer.candidate
        XCTAssertEqual(candidate.name, "Joe Biden")
        XCTAssertNotNil(candidate.age)
        XCTAssertNotNil(candidate.position)
        XCTAssertEqual(candidate.position?.title, "President")
        XCTAssertEqual(candidate.position?.locality.name, "United States")
        XCTAssertNotNil(candidate.issue_views)
    }

    func testFetchCandidate() async throws {
        // Tests that the question provider will receive questions when querying api for questions without any
        // starting questions
        let provider = MockSingleCandidateProvider()
        let singleCandidateService = await SingleCandidateService(provider: provider)
        
        let _: @MainActor () async throws -> Void = {
            try await singleCandidateService.fetchCandidate(candidateID: 1)
            XCTAssert(singleCandidateService.candidate != nil)
        }
    }
}

