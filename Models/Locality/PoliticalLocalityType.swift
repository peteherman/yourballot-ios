//
//  PoliticalLocalityType.swift
//  Your Ballot
//
//  Created by Peter Herman on 4/9/24.
//

import Foundation

enum PoliticalLocalityType: String, Decodable {
    case town = "town"
    case city = "city"
    case state = "state"
    case federal = "federal"
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
