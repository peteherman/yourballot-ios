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

extension PoliticalLocalityType {
    var pretty: String {
        switch self {
        case .town:
            return "Town"
        case .city:
            return "City"
        case .state:
            return "State"
        case .federal:
            return "Federal"
        }
    }
}
