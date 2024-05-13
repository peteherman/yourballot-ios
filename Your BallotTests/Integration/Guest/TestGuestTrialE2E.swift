//
//  TestGuestTrialE2E.swift
//  Your BallotTests
//
//  Created by Peter Herman on 5/13/24.
//

import XCTest
@testable import Your_Ballot

final class TestGuestTrialE2E: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testBaseURIFromEnv() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        let environment = ProcessInfo.processInfo.environment
        let api_uri = environment["API_BASE_URI"]
        if api_uri == nil {
            XCTFail("API_BASE_URI was nil!")
            return
        }
        XCTAssertEqual(environment["API_BASE_URI"]!, "https://yourballot-staging.peteherman.codes")
    }
    
    func testGuestQuestionProviderNonEmptyListOfQuestions() async throws {
        let provider = URLSession(configuration: .default)
        let guestQuestionService = await GuestQuestionService(provider: provider)
        do {
            try await guestQuestionService.fetchQuestions()
            if await guestQuestionService.getQuestionQueue().count <= 0 {
                XCTFail("Guest Question Service Failed to Retrieve any Questions")
                return
            } else {
                await print(guestQuestionService.getQuestionQueue())
            }
        } catch {
            XCTFail("Received exception: \(error)")
        }
    }

}
