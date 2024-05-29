//
//  Core.swift
//  Your BallotTests
//
//  Created by Peter Herman on 5/29/24.
//

import Foundation

struct ResultInfo: Decodable {
    let next: String?
    let previous: String?
    let success: Bool
    let errors: [String]
}
