//
//  TestKeychainService.swift
//  Your BallotTests
//
//  Created by Peter Herman on 5/29/24.
//

import XCTest
@testable import Your_Ballot

final class TestKeychainService: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSavingAndGettingFromKeychainService() throws {
        let key = "Some Key"
        let value = "Some Value"
        
        KeychainService.shared.save(key, value: value)
        let receivedValue = KeychainService.shared.get(key)
        
        if receivedValue == nil {
            XCTFail("Received nil from .get")
        }
        
        let receivedValueString = receivedValue!
        XCTAssertEqual(value, receivedValueString)
    }
}
