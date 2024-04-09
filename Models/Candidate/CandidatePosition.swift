//
//  CandidatePosition.swift
//  Your BallotTests
//
//  Created by Peter Herman on 4/9/24.
//

import Foundation

struct CandidatePosition: Decodable {
    let id: Int
    let title: String
    let locality: PoliticalLocality
    let term_limit: Int?
}
