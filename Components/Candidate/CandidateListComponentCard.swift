//
//  CandidateListComponentCard.swift
//  Your Ballot
//
//  Created by Peter Herman on 4/13/24.
//

import SwiftUI

struct CandidateListComponentCard: View {
    let candidate: Candidate
    var body: some View {
        HStack {
            Image("BidenImage")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 75, height: 75)
                .clipped()
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                .padding([.leading, .trailing], 5)
                .padding([.top, .bottom], 3)
            VStack {
                Text("\(candidate.name)")
                Text("\(candidate.position?.title ?? "Candidate" )")
                    .font(.caption)
            }
            VStack {
                if candidate.similarityPercentage != nil {
                    Text("\(candidate.similarityPercentage!)%")
                    Text("match")
                        .font(.caption)
                } else {
                    Text("")
                }
            }
            .padding()
        }
        .background(Theme.light_blue.mainColor)
        .cornerRadius(10.0)
        
    }
}

#Preview {
    CandidateListComponentCard(candidate: Candidate.sampleData[0])
}
