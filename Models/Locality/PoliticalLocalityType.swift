//
//  PoliticalLocalityType.swift
//  Your Ballot
//
//  Created by Peter Herman on 4/9/24.
//

import Foundation

enum PoliticalLocalityType: String, Decodable {
    case town = "TOWN"
    case city = "CITY"
    case state = "STATE"
    case federal = "FEDERAL"
}
