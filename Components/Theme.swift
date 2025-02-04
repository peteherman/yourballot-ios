//
//  Theme.swift
//  Your Ballot
//
//  Created by Peter Herman on 3/18/24.
//

import SwiftUI
enum Theme: String {
    case light_blue
    case light_blue_accent
    case blue_accent
    case light_red
    case light_red_accent
    case red_accent
    case light_gray
    case white
    case deep_blue
    case deep_red
    case very_light_gray
    case candidate_blue
    case candidate_red
    
    var mainColor: Color {
        Color(rawValue)
    }
}
