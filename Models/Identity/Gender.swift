//
//  Gender.swift
//  Your Ballot
//
//  Created by Peter Herman on 3/29/24.
//

import Foundation

enum Gender: String, Codable, CaseIterable {
    case female = "Female"
    case male = "Male"
    case transgender = "Transgender"
    case nonbinary = "Nonbinary"
    case other = "Other"
    case choose_not_to_share = "Choose not to share"
}

extension Gender {
    func string() -> String {
        switch self {
        case .female:
            return "Female"
        case .male:
            return "Male"
        case .transgender:
            return "Transgender"
        case .nonbinary:
            return "Nonbinary"
        case .other:
            return "Other"
        case .choose_not_to_share:
            return "Choose not to share"
        }
    }
}
