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
    let url: URL?
    let twitter: URL?
    let facebook: URL?
}

extension Candidate {
    static let sampleData: [Candidate] =
    [
        Candidate(id: 1, external_id: UUID(), name: "Joe Biden", age: 81, bio: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec faucibus sapien metus, id tempor quam lacinia id. Quisque finibus placerat nisi. In hac habitasse platea dictumst. Suspendisse eu turpis sem. Cras convallis purus eget diam imperdiet sit.", days_served: 675, ethnicity: Ethnicity.not_hispanic_or_latino, political_identity: "Democrat", political_party: PoliticalParty.democratic, url: URL(string: "https://joebiden.com"), twitter: URL(string: "https://twitter.com/JoeBiden"), facebook: URL(string: "https://facebook.com/joebiden"))
    ]
}
