//
//  Candidate.swift
//  Your Ballot
//
//  Created by Peter Herman on 3/29/24.
//

import Foundation

 

struct Candidate {
    let id: Int64
    let external_id: UUID
    let name: String
    let age: Int
    let bio: String
    let days_served: Int
    let ethnicity: Ethnicity?
    let political_identity: String
    let political_party: PoliticalParty
}
