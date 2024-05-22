//
//  VoterCandidatesService.swift
//  Your Ballot
//
//  Created by Peter Herman on 4/12/24.
//

import Foundation

class VoterCandidatesSerializer: BaseSerializer {
    var candidates: [Candidate] = []
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
        let _ = try rootContainer.nestedContainer(keyedBy: PaginationCodingKeys.self, forKey: RootCodingKeys.result_info)
        let subCandidates = try rootContainer.decode([Candidate].self, forKey: RootCodingKeys.result)
        candidates = subCandidates
    }
}
