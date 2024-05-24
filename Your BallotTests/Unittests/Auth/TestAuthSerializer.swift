//
//  TestAuthSerializer.swift
//  Your BallotTests
//
//  Created by Peter Herman on 5/24/24.
//

import XCTest
@testable import Your_Ballot

final class TestAuthSerializer: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    func testAuthResponseSerializer() throws {
        let rawResponse = testVoterLoginResponse
        let decoder = JSONDecoder()
        let authResponseSerializer = try decoder.decode(AuthResponseSerializer.self, from: rawResponse)
        if authResponseSerializer.authTokens == nil {
            XCTFail("Failed to serialize auth response")
        }
        let authTokens = authResponseSerializer.authTokens!
        XCTAssertNotNil(authTokens.access)
        XCTAssertNotNil(authTokens.refresh)
        XCTAssertNotNil(authTokens.createdAt)
    }
}
