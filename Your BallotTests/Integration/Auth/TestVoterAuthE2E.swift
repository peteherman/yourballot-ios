//
//  TestVoterAuthE2E.swift
//  Your BallotTests
//
//  Created by Peter Herman on 5/28/24.
//

import XCTest
@testable import Your_Ballot

final class TestVoterAuthE2E: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testVoterLoginSuccess() async throws {
        let insecureDelegate = CustomSessionDelegate()
        let provider = URLSession(configuration: .default, delegate: insecureDelegate, delegateQueue: nil)
        
        let voterAuthService = VoterAuthService(provider: provider)
        do {
            let testUserEmail = "test@mail.com"
            let testUserPassword = "password"
            let authTokens = try await voterAuthService.login(email: testUserEmail, password: testUserPassword)
            XCTAssertNotNil(authTokens.access)
            XCTAssertNotNil(authTokens.refresh)

        } catch {
            XCTFail("Received exception: \(error)")
        }
    }
    
    func testVoterLoginFailure() async throws {
        let insecureDelegate = CustomSessionDelegate()
        let provider = URLSession(configuration: .default, delegate: insecureDelegate, delegateQueue: nil)
        
        let voterAuthService = VoterAuthService(provider: provider)
        do {
            let testUserEmail = "test@mail.com"
            let testUserPassword = "wrong-password"
            let authTokens = try await voterAuthService.login(email: testUserEmail, password: testUserPassword)
            XCTFail("Should have raised exception")
        } catch {
            // Do nothing as this exception is expected
        }
    }

}
