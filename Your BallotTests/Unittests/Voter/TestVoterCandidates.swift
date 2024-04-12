//
//  TestVoterCandidates.swift
//  Your BallotTests
//
//  Created by Peter Herman on 4/12/24.
//

import XCTest
@testable import Your_Ballot

final class TestVoterCandidates: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDeserializeVoterCandidates() throws {
        let rawResponse = testVoterCandidatesData
        let decoder = JSONDecoder()
        let candidateSerializer = try decoder.decode(VoterCandidatesSerializer.self, from: rawResponse)
        let candidates = candidateSerializer.candidates
        XCTAssertGreaterThan(candidates.count, 0)
    }
    
    func testFetchVoterCandidates() async throws {
        let provider = MockVoterCandidatesProvider()
        let voterCandidatesService = await VoterCandidatesService(provider: provider)
        let _: @MainActor () async throws -> Void = {
            try await voterCandidatesService.fetchCandidates()
            XCTAssertNotNil(voterCandidatesService.candidates)
            let candidates = voterCandidatesService.candidates
            XCTAssertGreaterThan(candidates.count, 0)
        }
    }

}
