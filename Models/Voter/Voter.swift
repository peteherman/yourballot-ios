//
//  Voter.swift
//  Your Ballot
//
//  Created by Peter Herman on 4/22/24.
//

import Foundation

struct Voter {
    let id: Int64
    let external_id: UUID
    let age: Int
    let zipcode: String
    let ethnicity: Ethnicity?
    let gender: Gender
    let races: Set<Race>
    let political_identity: String
    let political_party: PoliticalParty
    let issue_views: IssueViewsSummary?
}

extension Voter {
    static let sampleData: [Voter] = [
        Voter(id: 1, external_id: UUID(), age: 21, zipcode: "12831", ethnicity: .not_hispanic_or_latino, gender: .male, races: Set<Race>(arrayLiteral: .asian, .american_indian_or_alaska_native), political_identity: "Left leaning Independent", political_party: .independent, issue_views: [
            "Healthcare": 8.75,
            "Abortion": -9.25,
            "Gun Control": -5.0,
            "Environment": 8.0,
            "Immigration": -6.0
        ])
    ]
}
