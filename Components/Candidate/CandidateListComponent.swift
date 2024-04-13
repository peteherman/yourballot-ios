//
//  CandidateListComponent.swift
//  Your Ballot
//
//  Created by Peter Herman on 4/13/24.
//

import SwiftUI

struct CandidateListComponent: View {
    let candidates: [Candidate]
    var body: some View {
        VStack {
            ForEach(candidates, id: \.self.id) { candidate in
                CandidateListComponentCard(candidate: candidate)
            }
        }
    }
}

struct CandidateListComponent_Preview: PreviewProvider {
    static var previews: some View {
        CandidateListComponent(candidates: Candidate.sampleData)
    }
}
