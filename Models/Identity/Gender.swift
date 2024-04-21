//
//  Gender.swift
//  Your Ballot
//
//  Created by Peter Herman on 3/29/24.
//

import Foundation

enum Gender: String, Decodable, CaseIterable {
    case female = "Female"
    case male = "Male"
    case transgender = "Transgender"
    case nonbinary = "Nonbinary"
    case other = "Other"
    case choose_not_to_share = "Choose not to share"
}
