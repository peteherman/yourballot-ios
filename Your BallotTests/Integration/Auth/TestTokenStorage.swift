//
//  TestTokenStorage.swift
//  Your BallotTests
//
//  Created by Peter Herman on 5/29/24.
//

import XCTest
@testable import Your_Ballot

final class TestTokenStorage: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSaving() throws {
        let accessToken = "access"
        let refreshToken = "refresh"
        let authTokens = AuthTokens(access: accessToken, refresh: refreshToken, createdAt: Date())
        
        let tokenStorage = TokenStorage()
        tokenStorage.saveTokens(authTokens: authTokens)
        
        let accessTokenOpt = tokenStorage.getAccessToken()
        if let accessTokenOpt  {
            XCTAssertEqual(accessTokenOpt, accessToken)
        } else {
            XCTFail("Access token was nil")
        }
        
        let refreshTokenOpt = tokenStorage.getRefreshToken()
        if let refreshTokenOpt {
            XCTAssertEqual(refreshTokenOpt, refreshToken)
        } else {
            XCTFail("Refresh token was nil")
        }
    }
    
    func testUpdatingAccessToken() throws {
        let accessToken = "access"
        let refreshToken = "refresh"
        let authTokens = AuthTokens(access: accessToken, refresh: refreshToken, createdAt: Date())
        
        let tokenStorage = TokenStorage()
        tokenStorage.saveTokens(authTokens: authTokens)
        
        let updatedAccessToken = "updated"
        tokenStorage.updateAccessToken(accessToken: updatedAccessToken)
        
        let accessTokenOpt = tokenStorage.getAccessToken()
        if let accessTokenOpt  {
            XCTAssertEqual(accessTokenOpt, updatedAccessToken)
        } else {
            XCTFail("Access token was nil")
        }
        
    }

}
