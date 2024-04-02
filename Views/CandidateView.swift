//
//  CandidateView.swift
//  Your Ballot
//
//  Created by Peter Herman on 4/2/24.
//

import SwiftUI

struct CandidateView: View {
    var body: some View {
        CandidateCard(candidate: Candidate.sampleData[0])
    }
}

#Preview {
    CandidateView()
}
