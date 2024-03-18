//
//  Theme.swift
//  Your Ballot
//
//  Created by Peter Herman on 3/18/24.
//

import SwiftUI
enum Theme: String {
    case bubblegum
    case buttercup
    case indigo
    case lavender
    case magenta
    case navy
    case orange
    case oxblood
    case periwinkle
    case poppy
    case purple
    case seafoam
    case sky
    case tan
    case teal
    case yellow
    
    var mainColor: Color {
        Color(rawValue)
    }
}
