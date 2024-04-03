//
//  PoliticalIssueCard+Comparisoin.swift
//  Your Ballot
//
//  Created by Peter Herman on 4/3/24.
//

import SwiftUI

struct PoliticalIssueCard_Comparison: View {
    var body: some View {
        VStack {
            Text("Health care")
                .font(.caption)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding([.leading])
            
            
        }
        .background(Theme.light_blue.mainColor)
        .padding([.leading,.trailing])
        .cornerRadius(10.0)
    }
}

#Preview {
    PoliticalIssueCard_Comparison()
}
