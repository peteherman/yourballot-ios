//
//  PoliticalLocalit.swift
//  Your BallotTests
//
//  Created by Peter Herman on 4/9/24.
//

import Foundation

struct PoliticalLocality: Decodable {
    let id: Int
    let geo_json_id: UUID?
    let name: String
    let type: PoliticalLocalityType
}
