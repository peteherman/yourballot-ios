//
//  Race.swift
//  Your Ballot
//
//  Created by Peter Herman on 3/29/24.
//

import Foundation

enum Race: String, Codable, CaseIterable {
    case american_indian_or_alaska_native = "American Indian or Alaska Native"
    case asian = "Asian"
    case black_or_african_american = "Black or African American"
    case native_hawaiian_or_pacific_islander = "Native Hawaiian or Pacific Islander"
    case white = "White"
    case choose_not_to_share = "Choose not to share"
}

extension Race {
    func string() -> String {
        switch self {
        case .american_indian_or_alaska_native:
            return "American Indian or Alaska Native"
        case .asian:
            return "Asian"
        case .black_or_african_american:
            return "Black or African American"
        case .native_hawaiian_or_pacific_islander:
            return "Native Hawaiian or Pacific Islander"
        case .white:
            return "White"
        case .choose_not_to_share:
            return "Choose not to share"
        }
    }
}
