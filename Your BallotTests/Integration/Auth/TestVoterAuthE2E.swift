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
            let (authTokens, errorMessage) = try await voterAuthService.login(email: testUserEmail, password: testUserPassword)
            if let authTokens {
                XCTAssertNotNil(authTokens.access)
                XCTAssertNotNil(authTokens.refresh)
            } else {
                XCTFail("Received error message: \(errorMessage)")
            }

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
            let (authTokens, errorMessage) = try await voterAuthService.login(email: testUserEmail, password: testUserPassword)
            if errorMessage == "" || authTokens != nil {
                XCTFail("Should have received error message")
            }
        } catch {
            // Do nothing as this exception is expected
            XCTFail("Received unexpected exception! \(error.localizedDescription)")
        }
    }
    
    func testVoterTokenRefreshSuccess() async throws {
        let insecureDelegate = CustomSessionDelegate()
        let provider = URLSession(configuration: .default, delegate: insecureDelegate, delegateQueue: nil)
        
        let voterAuthService = VoterAuthService(provider: provider)
        do {
            // Login successfully
            let testUserEmail = "test@mail.com"
            let testUserPassword = "password"
            let (authTokens, errorMessage) = try await voterAuthService.login(email: testUserEmail, password: testUserPassword)
            if let authTokens {
                XCTAssertNotNil(authTokens.access)
                XCTAssertNotNil(authTokens.refresh)
                
                // Now refresh tokens
                _ = try await voterAuthService.refreshTokens(tokens: authTokens)
                XCTAssertNotNil(authTokens.access)
                XCTAssertNotNil(authTokens.refresh)
            } else {
                XCTFail("Authentication failed! \(errorMessage)")
            }
            
        } catch {
            XCTFail("Received exception: \(error)")
        }
    }
    
    func testVoterRegisterSuccess() async throws {
        let insecureDelegate = CustomSessionDelegate()
        let provider = URLSession(configuration: .default, delegate: insecureDelegate, delegateQueue: nil)
        
        let voterAuthService = VoterAuthService(provider: provider)
        do {
            // Login successfully
            let testUserEmail = "test2@mail.com"
            let testUserPassword = "password"
            let voterRegistration = VoterRegistrationRequestBody(email: testUserEmail, password: testUserPassword, zipcode: "12831", political_identity: "")
            let (authTokens, errorMessage): (AuthTokens?, String) = try await voterAuthService.register(registerBody: voterRegistration)
            XCTAssertNotNil(authTokens)
            XCTAssertNotNil(authTokens!.access)
            XCTAssertNotNil(authTokens!.refresh)
        } catch {
            XCTFail("Received exception: \(error)")
        }
    }

    func testVoterRegisterSuccessWithAllFields() async throws {
        let insecureDelegate = CustomSessionDelegate()
        let provider = URLSession(configuration: .default, delegate: insecureDelegate, delegateQueue: nil)
        
        let voterAuthService = VoterAuthService(provider: provider)
        do {
            // Login successfully
            let testUserEmail = "test3@mail.com"
            let testUserPassword = "password"
            let voterRegistration = VoterRegistrationRequestBody(email: testUserEmail, password: testUserPassword, zipcode: "12831", political_identity: "some political identity", age: 24, ethnicity: Ethnicity.choose_not_to_share, gender: Gender.other, race: Race.asian)
            let (authTokens, errorMessage): (AuthTokens?, String) = try await voterAuthService.register(registerBody: voterRegistration)
            XCTAssertNotNil(authTokens)
            XCTAssertNotNil(authTokens!.access)
            XCTAssertNotNil(authTokens!.refresh)
        } catch {
            XCTFail("Received exception: \(error)")
        }
    }
    
    func testVoterLoginFailureDecodeErrors() async throws {
        let insecureDelegate = CustomSessionDelegate()
        let provider = URLSession(configuration: .default, delegate: insecureDelegate, delegateQueue: nil)
        let voterAuthService = VoterAuthService(provider: provider)
        do {
            let testUserEmail = "test@mail.com"
            let testUserPassword = "wrong-password"
            
            let requestBody = VoterLoginRequestBody(email: testUserEmail, password: testUserPassword)
            let (responseData, httpResponse) = try await provider.postHttpResponse(data: requestBody, to: URL(string: "\(API_BASE)/v1/voter/login/")!)
            XCTAssertEqual(httpResponse.statusCode, 401)
            
            // Decode the response data now
            let decoder = JSONDecoder()
            let resultInfoSerializer = try decoder.decode(ResultInfoSerializer.self, from: responseData)
            let results = resultInfoSerializer.resultInfo
            print(results.errors)
            XCTAssertFalse(results.success)
        } catch {
            XCTFail("Post raised exception: \(error.localizedDescription)")
        }
    }
}
