//
//  CandidateCard.swift
//  Your Ballot
//
//  Created by Peter Herman on 4/2/24.
//

import SwiftUI

struct CandidateCard: View {
    let candidate: Candidate
    var body: some View {
        VStack {
            VStack {
                Image("BidenImage")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 100)
                    .clipped()
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                Text(candidate.name)
                    .font(.title2)
                HStack {
                    Text("Match")
                    Text("62%")
                }
                .padding()
                .background()
                .cornerRadius(15.0)
                HStack {
                    Link(destination: candidate.url!, label: {
                        VStack {
                            Image(systemName: "link")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .foregroundStyle(.black)
                        }
                        .padding(5.0)
                        .background(
                            Circle()
                                .fill(Theme.light_gray.mainColor)
                                .frame(width: 42, height: 42)
                        )
                    })
                    .padding()
                    Link(destination: candidate.twitter!, label: {
                        VStack {
                            Image(systemName: "link")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .foregroundStyle(.black)
                        }
                        .padding(5.0)
                        .background(
                            Circle()
                                .fill(Theme.light_gray.mainColor)
                                .frame(width: 42, height: 42)
                        )
                    })
                    .padding()
                    Link(destination: candidate.facebook!, label: {
                        VStack {
                            Image(systemName: "link")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .foregroundStyle(.black)
                        }
                        .padding(5.0)
                        .background(
                            Circle()
                                .fill(Theme.light_gray.mainColor)
                                .frame(width: 42, height: 42)
                        )
                    })
                    .padding()
                }
                Text(candidate.bio)
                    .frame(width: 320)
            }
            .padding()
            .background(Theme.light_blue.mainColor)
            .cornerRadius(10.0)
        }
    }
}

#Preview {
    CandidateCard(candidate: Candidate.sampleData[0])
}
