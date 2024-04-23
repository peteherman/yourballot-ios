//
//  PoliticalProfileHeaderView.swift
//  Your Ballot
//
//  Created by Peter Herman on 4/22/24.
//

import SwiftUI

struct PoliticalProfileHeaderView: View {
    let voter: Voter
    var body: some View {
        VStack {
            HStack {
                Text("Self-Identity")
                    .padding([.trailing], 10)
                Spacer()
                Text("\(voter.political_identity)")
                    .multilineTextAlignment(.trailing)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(10)
            .background(Theme.light_blue.mainColor)
            HStack {
                Text("Political Party")
                    .padding([.trailing], 10)
                Spacer()
                Text("\(voter.political_party.string())")
                    .multilineTextAlignment(.trailing)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(10)
            .background(Theme.light_blue.mainColor)
            HStack {
                Text("Ballot-Identity")
                    .padding([.trailing], 10)
                Spacer()
                Text("Coming Soon")
                    .multilineTextAlignment(.trailing)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(10)
            .background(Theme.light_blue.mainColor)
        }
    }
}

#Preview {
    PoliticalProfileHeaderView(voter: Voter.sampleData[0])
}
