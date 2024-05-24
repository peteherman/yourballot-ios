//
//  TestAuthTestData.swift
//  Your BallotTests
//
//  Created by Peter Herman on 5/24/24.
//

import Foundation

let testVoterRegisterResponse = """
{
    "result_info": {
        "next": null,
        "previous": null,
        "total": 0
    },
    "result": {
        "access": "test-access-token",
        "refresh": "test-refresh-token",
        "id": 123
    }
}
""".data(using: .utf8)!

let testVoterLoginResponse = """
{
    "result_info": {
        "next": null,
        "previous": null,
        "total": 0
    },
    "result": {
        "access": "test-access-token",
        "refresh": "test-refresh-token"
    }
}
""".data(using: .utf8)!
