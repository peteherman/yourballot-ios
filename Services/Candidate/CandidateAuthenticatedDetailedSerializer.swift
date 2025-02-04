//
//  CandidateAuthenticatedDetailedSerializer.swift
//  Your Ballot
//
//  Created by Peter Herman on 4/9/24.
//

import Foundation

class CandidateAuthenticatedDetailedSerializer: BaseSerializer {
    var candidate: Candidate = Candidate.sampleData[0]
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
        let _ = try rootContainer.nestedContainer(keyedBy: PaginationCodingKeys.self, forKey: RootCodingKeys.result_info)
        let decodedCandidate = try rootContainer.decode(Candidate.self, forKey: RootCodingKeys.result)
        candidate = decodedCandidate
    }
}
