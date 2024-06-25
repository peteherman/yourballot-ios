//
//  TestVoterProfile.swift
//  Your BallotTests
//
//  Created by Peter Herman on 6/25/24.
//

import XCTest
@testable import Your_Ballot

final class TestVoterProfile: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDeserializeVoterProfile() throws {
        let rawResponse = testVoterProfileData
        let decoder = JSONDecoder()
        let voterProfileSerializer = try decoder.decode(VoterProfileSerializer.self, from: rawResponse)
        let voter = voterProfileSerializer.voter
        XCTAssertEqual(voter.email, "test4@mail.com")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
