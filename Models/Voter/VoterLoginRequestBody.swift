//
//  VoterLoginRequest.swift
//  Your Ballot
//
//  Created by Peter Herman on 5/24/24.
//

import Foundation

struct VoterLoginRequestBody: Encodable {
    let email: String
    let password: String
}

