//
//  PoliticalProfileLabelCard.swift
//  Your Ballot
//
//  Created by Peter Herman on 4/3/24.
//

import SwiftUI

struct PoliticalProfileLabelCard: View {
    let label: String
    let value: String
    var body: some View {
        HStack {
            Text(label)
            Spacer()
            Text(value)
        }
        .padding()
        .background(Theme.light_gray.mainColor)
        .padding([.leading, .trailing], 25)
    }
}

#Preview {
    PoliticalProfileLabelCard(label: "Position", value: "President")
}
